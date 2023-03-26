import axios from "axios";
import { API_URL } from "../utils/constants";
import { getStoredUserAuth } from "../utils/helpers";

const instance = axios.create({
  baseURL: API_URL,
  timeout: 5000,
});

instance.interceptors.request.use(
  async (config) => {
    const { accessToken, refreshToken } = getStoredUserAuth();
    if (accessToken) {
      config.headers.Authorization = `Bearer ${accessToken}`;
    }
    if (refreshToken) {
      config.headers["X-Refresh-Token"] = refreshToken;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export { instance as axiosInstance };
