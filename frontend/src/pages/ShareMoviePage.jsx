import { useState, useContext } from "react";
import styled from "@emotion/styled";
import { shareMovie } from "../services/movieApi";
import { useNavigate } from "react-router-dom";
import { errorContext } from "../contexts/ErrorContext";

const ShareMoviePageDiv = styled.div`
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;

  form {
    margin: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
    label {
      font-weight: bold;
    }
    input {
      border: 1px solid #ccc;
      width: 350px;
    }
  }
`;

export default function ShareMoviePage() {
  const navigate = useNavigate();
  const error = useContext(errorContext);
  const [url, setUrl] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    shareMovie(url)
      .then(() => {
        navigate("/");
      })
      .catch((err) => {
        error.addError(err.response.data);
      });
  };

  return (
    <ShareMoviePageDiv>
      <h1>Share a Youtube movie</h1>
      <form onSubmit={handleSubmit}>
        <label>Youtube URL</label>
        <input type='text' onChange={(e) => setUrl(e.target.value)} />
        <button type='submit'>Share</button>
      </form>
    </ShareMoviePageDiv>
  );
}
