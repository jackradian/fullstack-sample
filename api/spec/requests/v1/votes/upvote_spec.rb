require "rails_helper"

RSpec.describe "PUT /v1/movies/:id/upvote", type: :request do
  let(:request) {
    put "/v1/movies/#{movie_id}/upvote", headers: headers, as: :json
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

      it "returns upvoted message" do
        request
        expect(json[:message]).to eq("Upvoted")
      end

      context "when the user did not vote the movie" do
        it "creates a vote" do
          expect { request }.to change(Vote, :count).by(1)
        end
      end

      context "when the user has already upvoted the movie" do
        let!(:vote) {
          FactoryBot.create(
            :vote,
            user: user,
            movie: movie,
            vote_type: :upvote
          )
        }

        it "does not create a vote" do
          expect { request }.not_to change(Vote, :count)
        end

        it "does not change vote_type of existing vote" do
          expect {
            request
            vote.reload
          }.not_to change(vote, :vote_type)
        end
      end

      context "when the user has already downvoted the movie" do
        let!(:vote) {
          FactoryBot.create(
            :vote,
            user: user,
            movie: movie,
            vote_type: :downvote
          )
        }

        it "does not create a vote" do
          expect { request }.not_to change(Vote, :count)
        end

        it "changes vote_type to upvote" do
          expect {
            request
            vote.reload
          }.to change(vote, :vote_type).from("downvote").to("upvote")
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
