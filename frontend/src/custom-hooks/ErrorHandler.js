import React from "react";
import { parseErrorResponse } from "../utils/helpers";

function useErrorHandler(initialState) {
  const [error, setError] = React.useState(initialState);

  const addError = (error) => {
    const errorMessage = parseErrorResponse(error);
    window.localStorage.setItem("Error", errorMessage);
    setError(errorMessage);
  };

  const removeError = () => {
    window.localStorage.removeItem("Error");
    setError("");
  };

  return {
    error,
    addError,
    removeError,
  };
}

export default useErrorHandler;
