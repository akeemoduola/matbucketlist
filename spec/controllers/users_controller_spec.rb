require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { params: @user_attributes }, format: :json
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:message]).to eql "Account Created Successfully"
      end

      it "returns a 201 http status" do
        expect(response).to have_http_status(:created)
      end
    end

    context "when is not created" do
      before(:each) do
        # notice I'm not including the email
        @invalid_user_attributes = FactoryGirl.attributes_for(:user, email: nil)
        post :create, { params: @invalid_user_attributes }, format: :json
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:email]).to include "can't be blank"
      end

      it "returns a 422 http status" do
        expect(response).to have_http_status(422)
      end
    end
  end
end
