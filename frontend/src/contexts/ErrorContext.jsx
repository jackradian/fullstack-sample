import React from "react";
import useErrorHandler from "../custom-hooks/ErrorHandler";
import { getStoredError } from "../utils/helpers";

export const errorContext = React.createContext({
  error: "",
  addError: () => {},
  removeError: () => {},
});

const { Provider } = errorContext;

const ErrorProvider = ({ children }) => {
  const { error, addError, removeError } = useErrorHandler(getStoredError());

  return (
    <Provider value={{ error, addError, removeError }}>{children}</Provider>
  );
};

export default ErrorProvider;
