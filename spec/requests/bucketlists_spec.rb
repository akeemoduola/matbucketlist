require "rails_helper"

RSpec.describe "Bucketlists", type: :request do
  describe "GET /bucketlists" do
    before do
      @user = FactoryGirl.create :user
      login_helper @user
      @json_response = JSON.parse(response.body, symbolize_names: true)
      @token = @json_response[:token]
    end
    it "returns all bucketlists for user" do
      get api_bucketlists_path, headers: { Authorization: @token }
      expect(response).to have_http_status(200)
    end
  end
end
