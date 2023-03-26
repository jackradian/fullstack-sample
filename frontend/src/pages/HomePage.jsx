import { useState, useEffect } from "react";
import { getMovies } from "../services/movieApi";
import Movie from "../components/Movie";
import styled from "@emotion/styled";

const HomePageDiv = styled.div`
  display: flex;
  flex-direction: column;
`;

export default function HomePage() {
  const [movies, setMovies] = useState([]);

  useEffect(() => {
    getMovies().then((res) => setMovies(res.movies));
  }, []);

  return (
    <HomePageDiv>
      {movies.map((movie) => (
        <Movie
          key={movie.id}
          url={movie.url}
          uploadedUsername={movie.username}
        />
      ))}
    </HomePageDiv>
  );
}
