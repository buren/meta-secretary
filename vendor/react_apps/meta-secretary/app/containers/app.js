
import React from 'react';
import { connect } from 'react-redux';

import { Deploys } from 'containers/Deploys';

@connect(s => s.app)
export class App extends React.Component {
    render() {
        var { deploys } = this.props;
        return (
          <div>
            <h3>ReactMeta</h3>
            <Deploys deploys={deploys}></Deploys>
          </div>
        );
    }
}
