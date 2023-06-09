# == Schema Information
#
# Table name: movies
#
#  id              :bigint           not null, primary key
#  downvotes_count :integer          default(0), not null
#  upvotes_count   :integer          default(0), not null
#  url             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_movies_on_created_at  (created_at)
#  index_movies_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class MovieSerializer < Panko::Serializer
  attributes :id, :url, :username, :upvotesCount, :downvotesCount

  def username
    object.user.username
  end

  def upvotesCount
    object.upvotes_count
  end

  def downvotesCount
    object.downvotes_count
  end
end
