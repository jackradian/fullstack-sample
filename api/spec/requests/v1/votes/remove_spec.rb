require "rails_helper"

RSpec.describe "DELETE /v1/movies/:id/remove_vote", type: :request do
  let(:request) {
    delete "/v1/movies/#{movie_id}/remove_vote", headers: headers, as: :json
  }

  context "when being signed in" do
    let(:headers) { auth_headers }
    let(:user) { FactoryBot.create(:user) }

    context "with a movie that exists" do
      let(:movie) { FactoryBot.create(:movie) }
      let(:movie_id) { movie.id }

      it "returns http success" do
        request
        expect(response).to have_http_status(:success)
      end

      it "returns vote removed message" do
        request
        expect(json[:message]).to eq("Vote removed")
      end

      context "when the user did not vote the movie" do
        it "does not delete any vote" do
          expect {request}.not_to change(Vote, :count)
        end
      end

      context "when the user has already voted the movie" do
        let!(:vote) {
          FactoryBot.create(
            :vote,
            user: user,
            movie: movie
          )
        }

        it "deletes the vote" do
          expect {request}.to change(Vote, :count).by(-1)
        end
      end
    end

    context "with a movie that does not exist" do
      let(:movie_id) { 0 }

      it "returns http not found" do
        request
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  context "when not being signed in" do
    let(:headers) { {} }
    let(:movie_id) { 0 }

    it "returns http unauthorized" do
      request
      expect(response).to have_http_status(:unauthorized)
    end
  end
end