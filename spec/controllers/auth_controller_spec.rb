require "rails_helper"

RSpec.describe Api::V1::AuthController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create :user
  end
  describe "POST #login" do
    context "when the credentials are correct" do
      before(:each) do
        credentials = { email: @user.email, password: @user.password }
        post :login, params: credentials
      end

      it "returns user token" do
        expect(json_response).to have_key(:token)
      end

      it "returns a 200 http status" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when the credentials are incorrect" do
      before(:each) do
        credentials = { email: @user.email, password: nil }
        post :login, params: credentials
      end

      it "returns an error" do
        expect(json_response).to have_key(:error)
      end

      it "returns a json with an error" do
        expect(json_response[:error]).to eql "Invalid email or password"
      end

      it "returns a 401 http status" do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "GET #logout" do
    before(:each) do
      credentials = { email: @user.email, password: @user.password }
      post :login, params: credentials
      @token = json_response[:token]
      @user.reload
    end

    it "returns success if valid token" do
      request.headers["Authorization"] = @token
      get :logout
      expect(response).to have_http_status(:success)
    end

    it "should not allow access if no valid token" do
      get :logout
      expect(response).to have_http_status(401)
    end
  end
end
