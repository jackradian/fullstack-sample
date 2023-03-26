import { axiosInstance } from "./request";

export const login = async ({ username, password }) => {
  const data = {
    username: username,
    password: password,
  };
  const response = await axiosInstance.post("/v1/login", data);
  return response.data;
};
