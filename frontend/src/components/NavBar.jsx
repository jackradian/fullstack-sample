import { useState, useContext } from "react";
import { Link } from "react-router-dom";
import { login, logout } from "../services/authApi";
import { authContext } from "../contexts/AuthContext";
import styled from "@emotion/styled";

const NavBarDiv = styled.div`
  display: flex;
  background-color: #28ac94;
  height: 56px;
  a {
    color: white;
    text-decoration: none;
  }
  a:active {
    color: white;
  }
  .home-link {
    font-size: 1.5rem;
    font-weight: bold;
    padding: 10px;
  }
  .menu-right {
    margin-left: auto;
    display: flex;
    padding-right: 10px;
    form {
      input[type="text"],
      input[type="password"] {
        margin: 10px;
      }
    }
  }
  .menu-text {
    margin: 10px;
    font-size: 1.2rem;
    color: white;
  }
  .menu-button {
    margin: 10px;
  }
  .menu-link {
    margin: 10px;
    text-decoration: none;
    text-align: center;
    line-height: 1.9rem;
    background-color: #eeeeee;
    color: black;
    padding: 2px 6px 2px 6px;
  }
  .menu-link:hover {
    background-color: #cccccc;
  }
`;

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

  const handleLogout = () => {
    logout().then(() => {
      auth.setUnauthStatus();
    });
  };

  return (
    <NavBarDiv>
      <Link className='home-link' to='/'>
        Funny Movies
      </Link>
      <div className='menu-right'>
        {auth.auth.accessToken ? (
          <>
            <div className='menu-text'>Welcome {auth.auth.username}</div>
            <Link className='menu-link' to='/share'>
              Share a movie
            </Link>
            <button
              type='button'
              className='menu-button'
              onClick={handleLogout}>
              Logout
            </button>
          </>
        ) : (
          <form onSubmit={handleSubmit}>
            <input
              type='text'
              placeholder='Username'
              onChange={(e) => setUsername(e.target.value)}
            />
            <input
              type='password'
              placeholder='Password'
              onChange={(e) => setPassword(e.target.value)}
            />
            <button type='submit'>Login / Register</button>
          </form>
        )}
      </div>
    </NavBarDiv>
  );
}
