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
class Movie < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :upvotes,
    -> { where vote_type: :upvote },
    class_name: "Vote",
    inverse_of: :movie,
    dependent: :destroy
  has_many :downvotes,
    -> { where vote_type: :downvote },
    class_name: "Vote",
    inverse_of: :movie,
    dependent: :destroy

  validates :url, presence: true
  validates :url, format: {
    with: /\A(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.+\z/,
    message: "is not a valid YouTube URL"
  }
end
