/**
 * app startup script for development purpose
 */

require('./index.less');
const __DEBUG__ = true;

import React from 'react';
import ReactDOM from 'react-dom';

import { App } from 'containers/app';
import { makeStore } from 'utils/store';

var Main = require(__DEBUG__ ? 'utils/main-debug' : 'utils/main').Main;
var store = makeStore(__DEBUG__, {});

export function start(targetEl) {
    ReactDOM.render((
        <Main
            app={App}
            store={store} />
    ), targetEl);
}
