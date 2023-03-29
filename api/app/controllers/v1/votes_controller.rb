class V1::VotesController < V1::BaseController
  before_action :get_movie_and_existing_vote, only: [:upvote, :downvote, :remove]

  def upvote
    if @vote.present?
      if @vote.upvote?
        render_errors("Already upvoted", :forbidden)
        return
      end
      @vote.update!(vote_type: :upvote)
    else
      current_user.votes.create!(movie_id: @movie.id, vote_type: :upvote)
    end
    render_movie_vote_count
  end

  def downvote
    if @vote.present?
      if @vote.downvote?
        render_errors("Already downvoted", :forbidden)
        return
      end
      @vote.update!(vote_type: :downvote)
    else
      current_user.votes.create!(movie_id: @movie.id, vote_type: :downvote)
    end
    render_movie_vote_count
  end

  def remove
    if @vote.present?
      @vote.destroy!
      render_movie_vote_count
    else
      render_errors("No vote to remove", :not_found)
    end
  end

  private

  def get_movie_and_existing_vote
    @movie = Movie.find(params[:id])
    @vote = current_user.votes.find_by(movie_id: @movie.id)
  end

  def render_movie_vote_count
    render json: MovieSerializer.new(
      only: [:upvotesCount, :downvotesCount]
    ).serialize_to_json(@movie.reload)
  end
end
