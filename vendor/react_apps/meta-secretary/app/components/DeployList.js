
import React from 'react';
import { connect } from 'react-redux';

import { getDeploys } from 'services/deploys-service';

@connect(s => s.app)
export class DeployList extends React.Component {
    render() {
        var listItems = this.props.deploys.map(function(deploy) {
            var { name, data } = deploy;
            var days = '';
            for (var day in data) {
                if (data.hasOwnProperty(day)) {
                    days += day +  ' ' + data[day] + ', ';
                }
            }

            const itemText = [name, data.Sun, days].join(' ');
            return <li key={name}>{itemText}</li>;
        });

        return (
          <div>
            <ul>{listItems}</ul>
          </div>
        );
    }
}
