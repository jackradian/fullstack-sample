class V1::MoviesController < V1::BaseController
  skip_before_action :authorize_access_request!, only: [:index]

  def index
    movies = Movie.includes(:user).all.order(created_at: :desc)

    render json: Panko::Response.new(
      total_count: movies.count,
      movies: Panko::ArraySerializer.new(movies, each_serializer: MovieSerializer)
    )
  end

  def create
    movie = current_user.movies.create!(movie_params)
    render json: MovieSerializer.new.serialize_to_json(movie)
  end

  def my_list
    movies = current_user.movies.order(created_at: :desc)

    render json: Panko::Response.new(
      total_count: movies.count,
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
