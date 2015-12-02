import * as actionTypes from '../constants/deployConstants';

export function updateName(name) {
  return {
    type: actionTypes.DEPLOYS_TITLE_NAME_UPDATE,
    name,
  };
}
