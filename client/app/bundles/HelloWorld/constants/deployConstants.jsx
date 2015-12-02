// See https://www.npmjs.com/package/mirror-creator
// Allows us to easily setup constants inside of
// client/app/bundles/HelloWorld/actions/deploysActionCreators.jsx
import mirrorCreator from 'mirror-creator';

export default mirrorCreator([
  'DEPLOYS_TITLE_NAME_UPDATE',
]);
