const ExtractTextPlugin = require('extract-text-webpack-plugin');
const { resolve, basename, join, extname } = require('path');
const { sync } = require('glob');

const extractTextPlugin = new ExtractTextPlugin('css/app.css');

module.exports = {
  entry:
    sync(join(__dirname, 'web/static', 'js', '*.js')).reduce((map, filePath) => {
      const newMap = map;
      newMap[basename(filePath, extname(filePath))] = filePath;
      return newMap;
    }, {}),

  output: {
    path: resolve(__dirname, 'priv/static'),
    filename: 'js/[name].js'
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: 'babel-loader'
      },
      {
        test: /\.css$/,
        use: extractTextPlugin.extract({
          fallback: 'style-loader',
          use: 'css-loader'
        })
      },
      {
        test: /\.scss$/,
        use: extractTextPlugin.extract({
          fallback: 'style-loader',
          use: ['css-loader', 'sass-loader']
        })
      },
      {
        test: /\.(ttf|otf|eot|svg|woff2?)(\?.+)?$/,
        exclude: /node_modules/,
        use: {
          loader: 'url-loader',
          options: {
            limit: 10000,
            name: 'fonts/[name].[ext]'
          }
        }
      },
      {
        test: /\.(jpe?g|png|gif|svg)(\?.+)?$/,
        include: [
          resolve(__dirname, 'web/static/images')
        ],
        use: {
          loader: 'url-loader',
          options: {
            limit: 10000,
            name: 'images/[name].[ext]'
          }
        }
      },
      {
        test: /\.(ico|txt)$/,
        use: {
          loader: 'file-loader',
          options: {
            name: '[name].[ext]'
          }
        }
      }
    ]
  },

  plugins: [
    extractTextPlugin
  ]
};
