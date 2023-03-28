# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  vote_type  :integer          default(0), not null
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
require "rails_helper"

RSpec.describe Vote, type: :model do
  it "is valid with user, movie and vote_type" do
    expect(FactoryBot.build(:vote)).to be_valid
  end

  it "is invalid without vote_type" do
    expect(FactoryBot.build(:vote, vote_type: nil)).to be_invalid
  end

  it "is invalid with a vote_type that is not upvote or downvote" do
    expect {
      FactoryBot.build(:vote, vote_type: 2)
    }.to raise_error(ArgumentError)
  end

  it "is invalid without a user" do
    expect(FactoryBot.build(:vote, user: nil)).to be_invalid
  end

  it "is invalid without a movie" do
    expect(FactoryBot.build(:vote, movie: nil)).to be_invalid
  end

  it "is invalid with a duplicate user and movie" do
    existing_vote = FactoryBot.create(:vote)

    expect(FactoryBot.build(
      :vote,
      user_id: existing_vote.user_id,
      movie_id: existing_vote.movie_id
    )).to be_invalid
  end
end
