import React from "react";
import ReactDOM from "react-dom";
import configureStore from "./store/store";

import Root from "./components/root";

document.addEventListener("DOMContentLoaded", () => {



  const root = document.getElementById("root");
  let store;
  let initialState = {}

  if (window.currentUser) {
    initialState = {session: {currentUser: window.currentUser}};  
  }

  store = configureStore(initialState);

  window.store = store;
  ReactDOM.render(<Root store={store} />, root);
});
