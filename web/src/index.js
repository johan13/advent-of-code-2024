import { answers, inputs } from "./data.js";
import { startLogEntry, finishLogEntry } from "./log.js";
import { loadSolver } from "./wasm.js";

main().catch(console.error);

async function main() {
    let solve;
    const wasmEntry = startLogEntry("Load WebAssembly");
    try {
        solve = await loadSolver()
        finishLogEntry(wasmEntry, "OK");
    } catch (error) {
        console.error(error);
        finishLogEntry(wasmEntry, "Error", false);
        return;
    }

    for (let day = 1; ; day++) {
        const input = inputs[day];
        if (input === undefined) break;

        for (const part of [1, 2]) {
            const correct = answers[day][part - 1];
            const entry = startLogEntry(`Day ${day} part ${part}`);
            try {
                const answer = await solve(day, part, input);
                finishLogEntry(entry, answer, answer == correct);
            } catch (error) {
                console.error(error);
                finishLogEntry(entry, "Error", false);
            }
        }
    }
}
