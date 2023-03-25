require "rails_helper"

RSpec.describe "GET /v1/movies", type: :request do
  let(:request) { get "/v1/movies", as: :json }

  it "return http success" do
    request
    expect(response).to have_http_status(:success)
  end

  it "returns the movies in descending order", :aggregate_failures do
    movie1 = FactoryBot.create(:movie, created_at: 1.day.ago)
    movie2 = FactoryBot.create(:movie, created_at: 2.days.ago)

    request
    expect(json[:movies].first[:id]).to eq(movie1.id)
    expect(json[:movies].last[:id]).to eq(movie2.id)
  end
end
