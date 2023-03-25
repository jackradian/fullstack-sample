# == Schema Information
#
# Table name: movies
#
#  id         :bigint           not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
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
require "rails_helper"

RSpec.describe Movie, type: :model do
  it "is valid with url" do
    expect(FactoryBot.build(:movie)).to be_valid
  end

  it "is invalid without url" do
    movie = FactoryBot.build(:movie, url: nil)
    movie.valid?
    expect(movie.errors[:url]).to include("can't be blank")
  end

  it "is invalid with a url that is not a youtube url" do
    movie = FactoryBot.build(:movie, url: "https://www.google.com")
    movie.valid?
    expect(movie.errors[:url]).to include("is not a valid YouTube URL")
  end

  it "is invalid without a user" do
    movie = FactoryBot.build(:movie, user: nil)
    movie.valid?
    expect(movie.errors[:user]).to include("must exist")
  end
end
