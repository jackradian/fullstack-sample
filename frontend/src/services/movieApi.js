import { axiosInstance } from "./request";

export const getMovies = async () => {
  const response = await axiosInstance.get("/v1/movies");
  return response.data;
};

export const shareMovie = async (url) => {
  const response = await axiosInstance.post("/v1/movies", { url });
  return response.data;
};

export const upvoteMovie = async (id) => {
  const response = await axiosInstance.put(`/v1/movies/${id}/upvote`);
  return response.data;
};

export const downvoteMovie = async (id) => {
  const response = await axiosInstance.put(`/v1/movies/${id}/downvote`);
  return response.data;
};

export const removeVote = async (id) => {
  const response = await axiosInstance.delete(`/v1/movies/${id}/remove_vote`);
  return response.data;
};
