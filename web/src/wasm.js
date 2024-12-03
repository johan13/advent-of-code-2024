import { WASI, File, OpenFile, ConsoleStdout } from "@bjorn3/browser_wasi_shim";

/** @returns {Promise<(day: number, part: number, input: string) => Promise<bigint>>}> */
export async function loadSolver() {
    const fds = [
        new OpenFile(new File([])),
        ConsoleStdout.lineBuffered(msg => console.log(`[WASI stdout] ${msg}`)),
        ConsoleStdout.lineBuffered(msg => console.warn(`[WASI stderr] ${msg}`)),
    ];
    const wasi = new WASI([], [], fds, { debug: false });
    let __exports = {};
    const { instance } = await WebAssembly.instantiateStreaming(fetch("aoc24.wasm"), {
        ghc_wasm_jsffi: (await import(/* webpackIgnore: true */"./jsffi.js")).default(__exports),
        wasi_snapshot_preview1: wasi.wasiImport,
    });
    Object.assign(__exports, instance.exports);
    wasi.initialize(instance);

    return instance.exports.solve;
}
