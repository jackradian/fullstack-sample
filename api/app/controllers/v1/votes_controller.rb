class V1::VotesController < V1::BaseController
  before_action :get_movie_and_existing_vote, only: [:upvote, :downvote, :remove]

  def upvote
    if @vote.present?
      @vote.update!(vote_type: :upvote)
    else
      current_user.votes.create!(movie_id: @movie.id, vote_type: :upvote)
    end
    render json: {message: "Upvoted"}
  end

  def downvote
    if @vote.present?
      @vote.update!(vote_type: :downvote)
    else
      current_user.votes.create!(movie_id: @movie.id, vote_type: :downvote)
    end
    render json: {message: "Downvoted"}
  end

  def remove
    if @vote.present?
      @vote.destroy!
    end
    render json: {message: "Vote removed"}
  end

  private

  def get_movie_and_existing_vote
    @movie = Movie.find(params[:id])
    @vote = current_user.votes.find_by(movie_id: @movie.id)
  end
end
