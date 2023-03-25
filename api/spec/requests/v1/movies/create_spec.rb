require "rails_helper"

RSpec.describe "POST /v1/movies", type: :request do
  let(:request) { post "/v1/movies", params: params, headers: headers, as: :json }

  context "when being signed in" do
    let(:headers) { auth_headers }
    let(:user) { FactoryBot.create(:user) }

    context "with valid params" do
      let(:params) do
        {
          url: "https://www.youtube.com/watch?v=jNQXAC9IVRw"
        }
      end

      it "return http success" do
        request
        expect(response).to have_http_status(:success)
      end

      it "creates a movie" do
        expect { request }.to change(Movie, :count).by(1)
      end

      it "returns the movie" do
        request
        expect(json[:url]).to eq(params[:url])
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          url: "https://www.google.com"
        }
      end

      it "returns http unprocessable entity" do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the attributes errors" do
        request
        expect(json[:attributes_errors][:url]).to include("is not a valid YouTube URL")
      end

      it "does not create a movie" do
        expect { request }.not_to change(Movie, :count)
      end
    end
  end

  context "when not being signed in" do
    let(:headers) { {} }
    let(:params) { {} }

    it "returns http unauthorized" do
      request
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
