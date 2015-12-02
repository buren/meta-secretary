
var express = require('express');
var webpack = require('webpack');
var WebpackDevServer = require('webpack-dev-server');
var config = require('./webpack.config');
var pkg = require('./package.json');

var HOST = pkg.app.host;
var PORT = pkg.app.port;

var PROXY_HOST = HOST;
var PROXY_PORT = PORT + 1;

new WebpackDevServer(webpack(config), {
    publicPath: config.output.publicPath,
    hot: true,
    historyApiFallback: true,
    stats: {
        colors: true,
    },
    proxy: {
        '/account' : 'http://' + PROXY_HOST + ':' + PROXY_PORT + '/',
    },
}).listen(PORT, HOST, function(err) {
    if (err) { console.log(err); }
    console.log('Listening at localhost:' + PORT);
});





/**
 * Fake API
 */

var app = express();
app.get('/account', (req, res) => res.send('fake ok'));

var server = app.listen((PORT+1), function() {
    var port = server.address().port;
    console.log('Fake API /dist available at http://%s:%s', PROXY_HOST, PROXY_PORT);
});
