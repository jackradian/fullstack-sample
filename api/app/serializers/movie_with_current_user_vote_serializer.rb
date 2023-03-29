class MovieWithCurrentUserVoteSerializer < Panko::Serializer
  attributes :id, :url, :username, :upvotesCount, :downvotesCount, :myVote

  def upvotesCount
    object.upvotes_count
  end

  def downvotesCount
    object.downvotes_count
  end

  def myVote
    object.my_vote
  end
end
