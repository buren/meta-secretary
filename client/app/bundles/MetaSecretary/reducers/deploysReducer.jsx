import Immutable from 'immutable';

import * as actionTypes from '../constants/deployConstants';

export const $$initialState = Immutable.fromJS({
  name: '',
  deploys: [],
}); // this is the default state that would be used if one were not passed into the store

export default function deploysReducer($$state = $$initialState, action) {
  const { type, name } = action;

  switch (type) {
    case actionTypes.DEPLOYS_TITLE_NAME_UPDATE: {
      return $$state.set('name', name);
    }

    default: {
      return $$state;
    }
  }
}
