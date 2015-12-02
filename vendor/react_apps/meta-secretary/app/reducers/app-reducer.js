
import { SET_DEPLOYS } from 'actions/app-actions';

export const INITIAL_STATE = {
    deploys: [],
};

export function appReducer(state = INITIAL_STATE, action) {
    var { type, payload } = action;
    switch (type) {
        case SET_DEPLOYS:             return setDeploys(state, payload);
        default:                      return state;
    }
}

export function setDeploys(state, payload) {
    return {
        ...state,
        deploys: payload.deploys,
    };
}
