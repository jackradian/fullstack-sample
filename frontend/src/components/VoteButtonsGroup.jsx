import styled from "@emotion/styled";
import { useState, useContext } from "react";
import { errorContext } from "../contexts/ErrorContext";
import {
  MdThumbUp,
  MdThumbUpOffAlt,
  MdThumbDown,
  MdThumbDownOffAlt,
} from "react-icons/md";
import { upvoteMovie, downvoteMovie, removeVote } from "../services/movieApi";
import { VOTE_TYPE } from "../utils/constants";

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
  myVote,
}) {
  const error = useContext(errorContext);
  const [upvotes, setUpvotes] = useState(upvotesCount);
  const [downvotes, setDownvotes] = useState(downvotesCount);
  const [myVoteState, setMyVoteState] = useState(myVote);

  const updateVote = (newUpvotesCount, newDownvotesCount) => {
    setUpvotes(newUpvotesCount);
    setDownvotes(newDownvotesCount);
  };

  const handleUpvote = () => {
    upvoteMovie(movieId)
      .then(({ upvotesCount, downvotesCount }) => {
        updateVote(upvotesCount, downvotesCount);
        setMyVoteState(VOTE_TYPE.UPVOTE);
      })
      .catch((err) => {
        error.addError(err.response.data);
      });
  };

  const handleDownvote = () => {
    downvoteMovie(movieId)
      .then(({ upvotesCount, downvotesCount }) => {
        updateVote(upvotesCount, downvotesCount);
        setMyVoteState(VOTE_TYPE.DOWNVOTE);
      })
      .catch((err) => {
        error.addError(err.response.data);
      });
  };

  const handleRemoveVote = () => {
    removeVote(movieId)
      .then(({ upvotesCount, downvotesCount }) => {
        updateVote(upvotesCount, downvotesCount);
        setMyVoteState(null);
      })
      .catch((err) => {
        error.addError(err.response.data);
      });
  };

  return (
    <VoteButtonsGroupDiv>
      <div className='vote-wrapper'>
        {upvotes}
        {myVoteState === VOTE_TYPE.UPVOTE ? (
          <IconButton onClick={handleRemoveVote}>
            <MdThumbUp />
          </IconButton>
        ) : (
          <IconButton onClick={handleUpvote}>
            <MdThumbUpOffAlt />
          </IconButton>
        )}
      </div>
      <div className='vote-wrapper'>
        {downvotes}
        {myVoteState === VOTE_TYPE.DOWNVOTE ? (
          <IconButton onClick={handleRemoveVote}>
            <MdThumbDown />
          </IconButton>
        ) : (
          <IconButton onClick={handleDownvote}>
            <MdThumbDownOffAlt />
          </IconButton>
        )}
      </div>
    </VoteButtonsGroupDiv>
  );
}
