import { axiosInstance } from "./request";

export const getMovies = async () => {
  const response = await axiosInstance.get("/v1/movies");
  return response.data;
};

export const shareMovie = async (url) => {
  const response = await axiosInstance.post("/v1/movies", { url });
  return response.data;
};
