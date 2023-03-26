import { useState, useEffect } from "react";
import { getMovies } from "../services/movieApi";
import YoutubeIframe from "../components/YoutubeIframe";

export default function HomePage() {
  const [movies, setMovies] = useState([]);

  useEffect(() => {
    getMovies().then((res) => setMovies(res.movies));
  }, []);

  return (
    <div>
      {movies.map((movie) => (
        <div key={movie.id}>
          <YoutubeIframe url={movie.url} />
          <p>{movie.username}</p>
        </div>
      ))}
    </div>
  );
}
