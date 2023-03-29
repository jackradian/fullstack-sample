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

  describe "after_create #increase_votes_count" do
    it "increments upvotes_count if vote_type is upvote" do
      movie = FactoryBot.create(:movie)

      expect {
        FactoryBot.create(:vote, movie: movie, vote_type: described_class.vote_types[:upvote])
      }.to change(movie, :upvotes_count).by(1)
    end

    it "increments downvotes_count if vote_type is downvote" do
      movie = FactoryBot.create(:movie)

      expect {
        FactoryBot.create(:vote, movie: movie, vote_type: described_class.vote_types[:downvote])
      }.to change(movie, :downvotes_count).by(1)
    end
  end

  describe "after_update #update_votes_count" do
    it "decrements upvotes_count and increments downvotes_count if vote_type change from upvote to downvote" do
      movie = FactoryBot.create(:movie)
      vote = FactoryBot.create(:vote, movie: movie, vote_type: described_class.vote_types[:upvote])

      expect {
        vote.update(vote_type: described_class.vote_types[:downvote])
      }.to change(movie, :upvotes_count).by(-1).and change(movie, :downvotes_count).by(1)
    end

    it "decrements downvotes_count and increments upvotes_count if vote_type change from downvote to upvote" do
      movie = FactoryBot.create(:movie)
      vote = FactoryBot.create(:vote, movie: movie, vote_type: described_class.vote_types[:downvote])

      expect {
        vote.update(vote_type: described_class.vote_types[:upvote])
      }.to change(movie, :downvotes_count).by(-1).and change(movie, :upvotes_count).by(1)
    end
  end

  describe "after_destroy #decrement_votes_count" do
    it "decrements upvotes_count if vote_type is upvote" do
      movie = FactoryBot.create(:movie)
      vote = FactoryBot.create(:vote, movie: movie, vote_type: described_class.vote_types[:upvote])

      expect {
        vote.destroy
      }.to change(movie, :upvotes_count).by(-1)
    end

    it "decrements downvotes_count if vote_type is downvote" do
      movie = FactoryBot.create(:movie)
      vote = FactoryBot.create(:vote, movie: movie, vote_type: described_class.vote_types[:downvote])

      expect {
        vote.destroy
      }.to change(movie, :downvotes_count).by(-1)
    end
  end
end
