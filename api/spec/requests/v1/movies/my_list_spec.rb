require "rails_helper"

RSpec.describe "GET /v1/movies/my_list", type: :request do
  let(:request) { get "/v1/movies/my_list", headers: headers, as: :json }

  context "when being signed in" do
    let(:headers) { auth_headers }
    let(:user) { FactoryBot.create(:user) }

    it "return http success" do
      request
      expect(response).to have_http_status(:success)
    end

    it "returns the user's movies", :aggregate_failures do
      movie = FactoryBot.create(:movie, user: user)
      request
      expect(json[:movies].first[:id]).to eq(movie.id)
      expect(json[:movies].first[:url]).to eq(movie.url)
      expect(json[:movies].first[:username]).to eq(user.username)
    end

    it "does not return other user's movies" do
      movie = FactoryBot.create(:movie)
      request
      expect(response.body).not_to include(movie.url)
    end

    it "returns the user's movies in descending order", :aggregate_failures do
      movie1 = FactoryBot.create(:movie, user: user, created_at: 1.day.ago)
      movie2 = FactoryBot.create(:movie, user: user, created_at: 2.days.ago)
      request
      expect(json[:movies].first[:id]).to eq(movie1.id)
      expect(json[:movies].last[:id]).to eq(movie2.id)
    end
  end

  context "when not being signed in" do
    let(:headers) { {} }

    it "returns http unauthorized" do
      request
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
