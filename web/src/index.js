import { answers, inputs } from "./data.js";
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

    for (let day = 1; ; day++) {
        await new Promise(resolve => setTimeout(resolve, 0)); // Don't busy loop.

        const input = inputs[day];
        if (!input) break;

        const [correct1, correct2] = answers[day];

        const entry1 = startLogEntry(`Day ${day} part 1`);
        try {
            const answer1 = await solve(day, 1, input);
            finishLogEntry(entry1, answer1, answer1 === correct1);
        } catch (error) {
            console.error(error);
            finishLogEntry(entry1, "Error", false);
        }

        const entry2 = startLogEntry(`Day ${day} part 2`);
        try {
            const answer2 = await solve(day, 2, input);
            finishLogEntry(entry2, answer2, answer2 === correct2);
        } catch (error) {
            console.error(error);
            finishLogEntry(entry2, "Error", false);
        }
    }
}
