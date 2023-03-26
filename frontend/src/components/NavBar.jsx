import { useState, useContext } from "react";
import { Link } from "react-router-dom";
import { login } from "../services/authApi";
import { authContext } from "../contexts/AuthContext";

export default function NavBar() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const auth = useContext(authContext);

  const handleSubmit = (e) => {
    e.preventDefault();
    login({ username, password })
      .then((data) => {
        auth.setAuthStatus({
          username: username,
          accessToken: data.access,
          refreshToken: data.refresh,
        });
      })
      .catch((err) => {
        console.log("Error: ", err);
      });
  };

  return (
    <div className='header'>
      <div>
        <Link to='/'>Funny Movies</Link>
        <ul>
          {auth.auth.accessToken && <li>Welcome {auth.auth.username}</li>}
          <li>
            <form onSubmit={handleSubmit}>
              <div>
                <input
                  type='text'
                  placeholder='Username'
                  onChange={(e) => setUsername(e.target.value)}
                />
              </div>
              <div></div>
              <div>
                <input
                  type='password'
                  placeholder='Password'
                  onChange={(e) => setPassword(e.target.value)}
                />
              </div>
              <div></div>
              <div>
                <button type='submit'>Login / Register</button>
              </div>
            </form>
          </li>
        </ul>
      </div>
    </div>
  );
}
