import { axiosInstance } from "./request";

export const getMovies = async () => {
  const response = await axiosInstance.get("/v1/movies");
  return response.data;
};
