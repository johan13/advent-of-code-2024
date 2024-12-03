const table = document.getElementById("log");

export function startLogEntry(message) {
    const row = table.insertRow();
    row.insertCell().textContent = message;

    return { row, start: performance.now() };
}

export function finishLogEntry(entry, answer, ok = true) {
    const duration = performance.now() - entry.start;
    const answerCell = entry.row.insertCell();
    answerCell.textContent = answer;
    if (!ok) answerCell.className = "error";
    entry.row.insertCell().textContent = `(${duration.toFixed(duration < 9.95 ? 1 : 0)} ms)`;
    entry.row = undefined;
}
