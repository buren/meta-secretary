/**
 * app startup script for production purpose
 */

require('./index.less');

import React from 'react';
import ReactDOM from 'react-dom';

import { makeStore } from 'utils/store';
import { App } from 'containers/app';
import { Main } from 'utils/main';

var store = makeStore(false);

export function start(targetEl) {
    ReactDOM.render((
        <Main
            app={App}
            store={store} />
    ), targetEl);
}
