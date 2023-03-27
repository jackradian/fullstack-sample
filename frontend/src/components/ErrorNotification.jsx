import { useContext } from "react";
import styled from "@emotion/styled";
import { errorContext } from "../contexts/ErrorContext";

const ErrorDiv = styled.div`
  position: fixed;
  top: 60px;
  left: 50%;
  transform: translateX(-50%);
  width: 400px;
  background-color: #ac2840;
  color: white;
  padding: 10px;
  border-radius: 5px;
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
  z-index: 100;
  display: flex;
  align-items: center;
  .close-btn {
    margin-left: auto;
    cursor: pointer;
    padding: 5px;
    font-size: 1rem;
    font-weight: bold;
    background: none;
    color: white;
    border: none;
  }
  .close-btn:hover {
    color: #28ac94;
  }
`;

export default function ErrorNotification() {
  const { error, removeError } = useContext(errorContext);

  const handleSubmit = () => {
    removeError();
  };

  if (error) {
    return (
      <ErrorDiv>
        <div>{error}</div>
        <button className='close-btn' onClick={handleSubmit}>
          X
        </button>
      </ErrorDiv>
    );
  }
  return null;
}
