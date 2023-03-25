require "rails_helper"

RSpec.describe "POST /v1/login", type: :request do
  let(:request) { post "/v1/login", params: params, as: :json }

  context "with exist username" do
    let(:user) { FactoryBot.create(:user) }

    context "with correct password" do
      let(:params) do
        {
          username: user.username,
          password: user.password
        }
      end

      it "returns http success" do
        request
        expect(response).to have_http_status(:success)
      end

      it "returns the access token" do
        request
        expect(json).to include(:access)
      end
    end

    context "with incorrect password" do
      let(:params) do
        {
          username: user.username,
          password: "incorrect"
        }
      end

      it "returns http unauthorized" do
        request
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context "with not exist username" do
    context "with valid password" do
      let(:new_user) { FactoryBot.build(:user) }
      let(:params) do
        {
          username: new_user.username,
          password: new_user.password
        }
      end

      it "returns http success" do
        request
        expect(response).to have_http_status(:success)
      end

      it "creates a user" do
        expect { request }.to change(User, :count).by(1)
      end

      it "returns the access token" do
        request
        expect(json).to include(:access)
      end
    end

    context "with invalid password" do
      let(:new_user) { FactoryBot.build(:user, password: "a" * 7) }
      let(:params) do
        {
          username: new_user.username,
          password: new_user.password
        }
      end

      it "returns http unprocessable entity" do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create a user" do
        expect { request }.not_to change(User, :count)
      end
    end
  end
end
