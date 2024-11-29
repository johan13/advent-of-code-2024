function startLogEntry(message) {
    const table = document.getElementById("log");
    const row = table.insertRow();
    const cell = row.insertCell();
    cell.textContent = message;
    return { row, start: performance.now() };
}

function finishLogEntry(entry, answer) {
    const duration = performance.now() - entry.start;
    entry.row.insertCell().textContent = answer;
    entry.row.insertCell().textContent = `(${duration.toFixed(
        duration < 9.95 ? 1 : 0
    )} ms)`;
    entry.row = undefined;
}

const entry1 = startLogEntry("Loading WebAssembly");
finishLogEntry(entry1, "");

setTimeout(() => {
    const entry2 = startLogEntry("Loading problem inputs");
    setTimeout(() => finishLogEntry(entry2, ""), 600);
}, 600);
