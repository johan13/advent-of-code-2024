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

        const [correct1, correct2] = answers[day];

        const entry1 = startLogEntry(`Day ${day} part 1`);
        try {
            const answer1 = Number(await solve(day, 1, input));
            finishLogEntry(entry1, answer1, answer1 === correct1);
        } catch (error) {
            console.error(error);
            finishLogEntry(entry1, "Error", false);
        }

        const entry2 = startLogEntry(`Day ${day} part 2`);
        try {
            const answer2 = Number(await solve(day, 2, input));
            finishLogEntry(entry2, answer2, answer2 === correct2);
        } catch (error) {
            console.error(error);
            finishLogEntry(entry2, "Error", false);
        }
    }
}
