# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  vote_type  :integer          default("upvote"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_votes_on_movie_id              (movie_id)
#  index_votes_on_user_id               (user_id)
#  index_votes_on_user_id_and_movie_id  (user_id,movie_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  enum vote_type: {upvote: 0, downvote: 1}

  validates :vote_type, presence: true, inclusion: {in: vote_types.keys}
  validates :user_id, uniqueness: {scope: :movie_id}

  after_create :increment_votes_count
  after_update :update_votes_count
  after_destroy :decrement_votes_count

  private

  def increment_votes_count
    if upvote?
      movie.increment(:upvotes_count)
    elsif downvote?
      movie.increment(:downvotes_count)
    end
    movie.save
  end

  def update_votes_count
    if vote_type_previously_changed?(from: "upvote", to: "downvote")
      movie.decrement(:upvotes_count)
      movie.increment(:downvotes_count)
    elsif vote_type_previously_changed?(from: "downvote", to: "upvote")
      movie.decrement(:downvotes_count)
      movie.increment(:upvotes_count)
    end
    movie.save
  end

  def decrement_votes_count
    if upvote?
      movie.decrement(:upvotes_count)
    elsif downvote?
      movie.decrement(:downvotes_count)
    end
    movie.save
  end
end
