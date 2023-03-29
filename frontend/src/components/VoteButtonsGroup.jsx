import styled from "@emotion/styled";
import { useState, useContext } from "react";
import { errorContext } from "../contexts/ErrorContext";
import { MdThumbUpOffAlt, MdThumbDownOffAlt } from "react-icons/md";
import { upvoteMovie, downvoteMovie, removeVote } from "../services/movieApi";

const VoteButtonsGroupDiv = styled.div`
  display: flex;
  align-items: center;
  gap: 10px;
  .vote-wrapper {
    display: flex;
    align-items: center;
  }
`;

const IconButton = styled.button`
  background: none;
  border: none;
  font-size: 1.5rem;
  padding: 0;
  margin-left: 5px;
  margin-top: 5px;
`;

export default function VoteButtonsGroup({
  movieId,
  upvotesCount,
  downvotesCount,
}) {
  const error = useContext(errorContext);
  const [upvotes, setUpvotes] = useState(upvotesCount);
  const [downvotes, setDownvotes] = useState(downvotesCount);

  const updateVote = ({ upvotesCount, downvotesCount }) => {
    setUpvotes(upvotesCount);
    setDownvotes(downvotesCount);
  };

  const handleUpvote = () => {
    upvoteMovie(movieId)
      .then(updateVote)
      .catch((err) => {
        error.addError(err.response.data);
      });
  };

  const handleDownvote = () => {
    downvoteMovie(movieId)
      .then(updateVote)
      .catch((err) => {
        error.addError(err.response.data);
      });
  };

  return (
    <VoteButtonsGroupDiv>
      <div className='vote-wrapper'>
        {upvotes}
        <IconButton onClick={handleUpvote}>
          <MdThumbUpOffAlt />
        </IconButton>
      </div>
      <div className='vote-wrapper'>
        {downvotes}
        <IconButton onClick={handleDownvote}>
          <MdThumbDownOffAlt />
        </IconButton>
      </div>
    </VoteButtonsGroupDiv>
  );
}
