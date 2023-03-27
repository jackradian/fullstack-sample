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

export const parseErrorResponse = (errorResponse) => {
  if ("errors" in errorResponse) {
    return errorResponse.errors.join(". ");
  } else if ("attributes_errors" in errorResponse) {
    let message = "";
    Object.keys(errorResponse.attributes_errors).forEach((attribute) => {
      const capitalizedAttribute =
        attribute.charAt(0).toUpperCase() + attribute.slice(1);
      errorResponse.attributes_errors[attribute].forEach((error) => {
        message += capitalizedAttribute + " " + error + ". ";
      });
    });
    return message;
  } else {
    return JSON.stringify(errorResponse);
  }
};

export const getStoredError = () => {
  const error = window.localStorage.getItem("Error");
  if (error) {
    return error;
  }
  return "";
};
