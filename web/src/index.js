import { answers } from "./answers.js";
import { startLogEntry, finishLogEntry } from "./log.js";
import { loadSolver } from "./wasm.js";

main().catch(console.error);

async function main() {
    const wasmEntry = startLogEntry("Loading WebAssembly");
    const solve = await loadSolver().catch(() => undefined);
    if (!solve) {
        finishLogEntry(wasmEntry, "Failed", false);
        return;
    }
    finishLogEntry(wasmEntry, "OK");

    const inputsEntry = startLogEntry("Loading problem inputs");
    const inputs = await loadInputs().catch(() => []);
    if (inputs.length === 0) {
        finishLogEntry(inputsEntry, "Failed", false);
        return;
    }
    finishLogEntry(inputsEntry, "OK");

    for (let day = 1; day <= inputs.length; day++) {
        await new Promise(resolve => setTimeout(resolve, 0)); // Don't busy loop.

        const input = inputs[day];
        const [correct1, correct2] = answers[day];

        const entry1 = startLogEntry(`Day ${day} part 1`);
        try {
            const answer1 = solve(day, 1, input);
            finishLogEntry(entry1, answer1, answer1 === correct1);
        } catch (error) {
            console.error(error);
            finishLogEntry(entry1, "Error", false);
        }

        const entry2 = startLogEntry(`Day ${day} part 2`);
        try {
            const answer2 = solve(day, 2, input);
            finishLogEntry(entry2, answer2, answer2 === correct2);
        } catch (error) {
            console.error(error);
            finishLogEntry(entry2, "Error", false);
        }
    }
}

async function loadInputs() {
    const inputs = {};
    for (let day = 1; ; day++) {
        const dayStr = `0${day}`.slice(-2);
        try {
            // Eh? Use fetch instead?
            const { default: input } = await import(`../../inputs/input${dayStr}.txt`);
            inputs[day] = input;
        } catch (error) {
            if (error.code === "ERR_MODULE_NOT_FOUND") return inputs;
            throw error;
        }
    }
}
