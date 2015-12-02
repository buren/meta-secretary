
import React from 'react';
import ReactDOM from 'react-dom';
import ReactTestUtils from 'react-addons-test-utils';

import { Provider } from 'react-redux';
import { makeStore } from 'utils/store';

import { App } from 'containers/App';

describe('App Container', function() {
    it('should render home screen', function() {
        var store = makeStore();
        var cmp = ReactTestUtils.renderIntoDocument((
            <Provider store={store}>
                <App />
            </Provider>
        ));
        var dom = ReactDOM.findDOMNode(cmp);

        expect(
            dom.innerHTML.indexOf('ReactMeta')
        ).to.not.equal(-1);
    });
});
