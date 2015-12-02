export const SET_DEPLOYS = 'app@setDeploys';

export function setDeploys(deploys) {
    return {
        type: SET_DEPLOYS,
        payload: { deploys },
    };
}
