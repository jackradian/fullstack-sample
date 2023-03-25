require "rails_helper"

RSpec.describe "POST /v1/login/refresh", type: :request do
  let(:request) { post "/v1/login/refresh", headers: headers, as: :json }

  context "with valid refresh token" do
    let(:user) { FactoryBot.create(:user) }
    let(:headers) { refresh_headers }

    it "returns http success" do
      request
      expect(response).to have_http_status(:success)
    end

    it "returns the access token" do
      request
      expect(json).to include(:access)
    end
  end

  context "with invalid refresh token" do
    it "returns http unauthorized" do
      request
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
