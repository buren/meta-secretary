import { setDeploys } from 'actions/app-actions';

import { jQuery } from 'jquery';

export function getDeploys() {
    return (dispatch, getState) => {
        $.ajax({
            url: '/charts/deploys_by_day',
        }).done(function(data) {
            dispatch(setDeploys(data));
        })
        .fail(function(data) {
            console.log('error', data);
        });
    };
}
