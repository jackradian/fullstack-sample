import { useState } from "react";
import styled from "@emotion/styled";
import { shareMovie } from "../services/movieApi";
import { useNavigate } from "react-router-dom";

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
  const [url, setUrl] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    shareMovie(url).then((res) => {
      navigate("/");
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
