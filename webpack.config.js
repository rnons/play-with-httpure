const webpack = require("webpack");

const rules = [
  {
    test: /\.ts$/,
    use: ["ts-loader"]
  }
];
module.exports = {
  context: __dirname,
  mode: "development",
  entry: {
    Index: ["./src/index.ts"]
  },
  output: {
    path: __dirname + "./dist",
    filename: "[name].js",
    publicPath: "http://localhost:8081/"
  },
  resolve: {
    modules: ["node_modules", "output", "src"],
    extensions: [".js", ".ts"]
  },
  module: {
    rules
  },
  devServer: {
    port: 8081
  }
};
