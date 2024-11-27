const CopyPlugin = require("copy-webpack-plugin");
const HtmlPlugin = require("html-webpack-plugin");

module.exports = {
    mode: "production",
    performance: { hints: false },
    plugins: [
        new CopyPlugin({ patterns: [{ from: "*.webp", context: "src" }] }),
        new HtmlPlugin({ template: "src/index.html" }),
    ],
};
