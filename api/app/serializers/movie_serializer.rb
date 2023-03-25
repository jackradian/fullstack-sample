class MovieSerializer < Panko::Serializer
  attributes :id, :url, :username

  def username
    object.user.username
  end
end
