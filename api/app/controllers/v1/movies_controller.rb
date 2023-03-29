class V1::MoviesController < V1::BaseController
  skip_before_action :authorize_access_request!, only: [:index]

  def index
    is_logged_in = false
    begin
      authorize_access_request!
      is_logged_in = true
    rescue JWTSessions::Errors::Unauthorized
      is_logged_in = false
    end

    if is_logged_in
      movies = Movie
        .select(
          :id,
          :url,
          :upvotes_count,
          :downvotes_count,
          :created_at,
          "users.username AS username",
          "votes.vote_type AS my_vote"
        )
        .joins(:user)
        .joins("LEFT OUTER JOIN votes ON votes.movie_id = movies.id AND votes.user_id = #{current_user.id}")
        .order(created_at: :desc)

      render json: Panko::Response.new(
        total_count: movies.size,
        movies: Panko::ArraySerializer.new(movies, each_serializer: MovieWithCurrentUserVoteSerializer)
      )
    else
      movies = Movie.includes(:user).all.order(created_at: :desc)

      render json: Panko::Response.new(
        total_count: movies.size,
        movies: Panko::ArraySerializer.new(movies, each_serializer: MovieSerializer)
      )
    end
  end

  def create
    movie = current_user.movies.create!(movie_params)
    render json: MovieSerializer.new.serialize_to_json(movie)
  end

  def my_list
    movies = current_user.movies.order(created_at: :desc)

    render json: Panko::Response.new(
      total_count: movies.size,
      movies: Panko::ArraySerializer.new(movies, each_serializer: MovieSerializer)
    )
  end

  private

  def movie_params
    params.permit(
      :url
    )
  end
end
