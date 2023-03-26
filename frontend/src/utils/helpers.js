import { DEFAULT_USER_AUTH } from "./constants";

// Return user auth from local storage value
export const getStoredUserAuth = () => {
  const auth = window.localStorage.getItem("UserAuth");
  if (auth) {
    return JSON.parse(auth);
  }
  return DEFAULT_USER_AUTH;
};

export const clearStoredUserAuth = () => {
  window.localStorage.removeItem("UserAuth");
};
