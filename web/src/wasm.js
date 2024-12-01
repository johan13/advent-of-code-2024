import { WASI, File, OpenFile, ConsoleStdout } from "@bjorn3/browser_wasi_shim";

export async function loadSolver() {
    const fds = [
        new OpenFile(new File([])),
        ConsoleStdout.lineBuffered(msg => console.log(`[WASI stdout] ${msg}`)),
        ConsoleStdout.lineBuffered(msg => console.warn(`[WASI stderr] ${msg}`)),
    ];
    const wasi = new WASI([], [], fds);
    const result = await WebAssembly.instantiateStreaming(fetch("solver.wasm"), {
        wasi_snapshot_preview1: wasi.wasiImport,
    });
    const { hs_init, solve } = result.instance.exports;
    hs_init(0, 0);

    return solve;
}
