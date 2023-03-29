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
FactoryBot.define do
  factory :vote do
    association :user
    association :movie
    vote_type { Vote.vote_types[:upvote] }
  end
end
