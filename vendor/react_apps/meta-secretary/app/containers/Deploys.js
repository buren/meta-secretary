
import React from 'react';
import { connect } from 'react-redux';

import { DeployList } from 'components/DeployList';

import { getDeploys } from 'services/deploys-service';

@connect(s => s.app)
export class Deploys extends React.Component {

    componentWillMount() {
        var { dispatch } = this.props;
        dispatch(getDeploys());
    }

    render() {
        var { deploys } = this.props;
        return (
          <div>
            <DeployList deploys={deploys}></DeployList>
          </div>
        );
    }
}
