// This file is our manifest of all reducers for the app.
// See also /client/app/bundles/HelloWorld/store/helloWorldStore.jsx
// A real world app will likely have many reducers and it helps to organize them in one file.
// `https://github.com/shakacode/react_on_rails/tree/master/docs/additional_reading/generated_client_code.md`
import deploysReducer from './deploysReducer';
import { $$initialState as $$helloWorldState } from './deploysReducer';

export default {
  $$helloWorldStore: deploysReducer,
};

export const initalStates = {
  $$helloWorldState,
};
