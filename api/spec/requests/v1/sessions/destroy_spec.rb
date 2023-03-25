require "rails_helper"

RSpec.describe "DELETE /v1/logout", type: :request do
  let(:request) { delete "/v1/logout", headers: headers, as: :json }

  context "with valid access token" do
    let(:user) { FactoryBot.create(:user) }
    let(:headers) { auth_headers }

    it "returns http success" do
      request
      expect(response).to have_http_status(:success)
    end
  end

  context "with invalid access token" do
    it "returns http unauthorized" do
      request
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
