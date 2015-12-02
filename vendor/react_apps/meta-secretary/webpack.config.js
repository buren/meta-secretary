var path = require('path');
var webpack = require('webpack');
var pkg = require('./package.json');

var serverUrl = 'webpack-dev-server/client?http://' + pkg.app.host + ':' + pkg.app.port;

module.exports = {
    devtool: 'sourcemaps',
    entry: {
        app: [
            serverUrl,
            'webpack/hot/only-dev-server',
            './app/app.dev',
        ],
        // specs: [
        //     serverUrl,
        //     'webpack/hot/only-dev-server',
        //     './specs/ui-specs',
        // ],
    },
    output: {
        path: path.join(__dirname, 'dist'),
        filename: pkg.name + '.js',
        publicPath: '/',
        library: pkg.name,
    },
    plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new webpack.NoErrorsPlugin(),
    ],
    resolve: {
        extensions: ['', '.js'],
        modulesDirectories: [
            'node_modules',
            path.join(__dirname, 'app'),
            path.join(__dirname, 'specs'),
        ],
    },
    module: {
        loaders: [
            {
                test: /\.js$/,
                loaders: [
                    'react-hot',
                    'babel?' + [
                        'optional[]=es7.classProperties',
                        'optional[]=es7.decorators',
                    ].join('&'),
                ],
                exclude: /node_modules/,
            },
            {
                test: /\.json$/,
                loader: 'json-loader',
            },
            {
                test: /\.css$/,
                loader: 'style-loader!css-loader',
            },
            {
                test: /\.scss$/,
                loaders: ['style', 'css', 'sass'],
            },
            {
                test: /\.less$/,
                loader: 'style!css!less',
            },
            {
                test: /\.(jpe?g|png|gif|svg)$/i,
                loader: 'url!img?optimizationLevel=7',
            },
            {
                test: /\.woff(\?v=\d+\.\d+\.\d+)?$/,
                loader: 'url?mimetype=application/font-woff',
            },
            {
                test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/,
                loader: 'url?mimetype=application/font-woff',
            },
            {
                test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,
                loader: 'url?mimetype=application/octet-stream',
            },
            {
                test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,
                loader: 'url?mimetype=application/vnd.ms-fontobject',
            },
            {
                test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,
                loader: 'url?mimetype=image/svg+xml',
            },
        ],
    },
};
