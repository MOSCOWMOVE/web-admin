const HtmlWebpackPlugin = require('html-webpack-plugin');
const path = require('path');

module.exports = {
  entry: './src/index.ts',
  module: {
      rules: [
        {
            test: /\.tsx?$/,
            use: 'ts-loader',
            exclude: /node_modules/,
        },
        {
            test: /\.(png|jpe?g|gif)$/i,
            use: [
              {
                loader: 'file-loader',
                
              },
            ]
        },
        {
          test: /\.(txt|csv)$/,
          use: [
            {
              loader: 'file-loader',
              options: {}
            }
          ]
        },
      ]
  },  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
  output: {
    path: path.resolve(__dirname, './dist'),
    filename: 'index_bundle.js',
  },
  
  plugins: [new HtmlWebpackPlugin({
      template: "./dist/templates/template.html"
  })],
  mode: "development"
};