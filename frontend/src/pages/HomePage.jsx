import { useState, useEffect, useContext } from "react";
import { getMovies } from "../services/movieApi";
import Movie from "../components/Movie";
import styled from "@emotion/styled";
import { errorContext } from "../contexts/ErrorContext";

const HomePageDiv = styled.div`
  display: flex;
  flex-direction: column;
`;

export default function HomePage() {
  const [movies, setMovies] = useState([]);
  const error = useContext(errorContext);

  useEffect(() => {
    getMovies()
      .then((res) => setMovies(res.movies))
      .catch((err) => {
        error.addError(err.response.data);
      });
  }, []);

  return (
    <HomePageDiv>
      {movies.length === 0 && <div>Have 0 movie</div>}
      {movies.map((movie) => (
        <Movie key={movie.id} {...movie} />
      ))}
    </HomePageDiv>
  );
}
