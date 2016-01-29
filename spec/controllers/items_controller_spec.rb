require "rails_helper"

RSpec.describe Api::V1::ItemsController, type: :request do
  before(:each) do
    @item = FactoryGirl.create :item
    login_helper @item.bucketlist.user
    @json_response = JSON.parse(response.body, symbolize_names: true)
    @token = @json_response[:token]
    @bucketlist_id = @item.bucketlist.id
  end
  describe "POST #create" do
    context "when it's successfully created" do
      before do
        post "/bucketlists/#{@bucketlist_id}/items", params: { name: @item[:name], bucketlist_id: @bucketlist_id }, headers: { Authorization: @token }
      end

      it "renders the json representation for the item record just created" do
        @json_response = JSON.parse(response.body, symbolize_names: true)
        expect(@json_response[:message]).to eql "Item successfully created."
      end

      it "returns a 201 http status" do
        expect(response).to have_http_status(:created)
      end

      it "creates a new Item" do
        expect do
          post "/bucketlists/#{@bucketlist_id}/items", params: { name: @item[:name], bucketlist_id: @bucketlist_id }, headers: { Authorization: @token }
        end.to change(Item, :count).by(1)
      end
    end

    context "when it's not created because of invalid params" do
      before do
        post "/bucketlists/#{@bucketlist_id}/items", params: { name: nil, bucketlist_id: @bucketlist_id }, headers: { Authorization: @token }
      end

      it "renders the json errors on why the user could not be created" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:name]).to include "can't be blank"
      end

      it "returns a 422 http status" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      before do
        put "/bucketlists/#{@bucketlist_id}/items/#{@item.id}", params: { done: (@item[:done] = true), bucketlist_id: @bucketlist_id }, headers: { Authorization: @token }
      end
      it "updates the requested item" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:message]).to eql "Item successfully updated."
      end

      it "returns a 200 http status" do
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid params" do
      before do
        put "/bucketlists/#{@bucketlist_id}/items/#{@item.id}", params: { name: nil, bucketlist_id: @bucketlist_id }, headers: { Authorization: @token }
      end
      it "renders the json errors on why the user could not be created" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:name]).to include "can't be blank"
      end

      it "returns a 422 http status" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested item" do
      expect do
        delete "/bucketlists/#{@bucketlist_id}/items/#{@item.id}", params: { bucketlist_id: @bucketlist_id }, headers: { Authorization: @token }
      end.to change(Item, :count).by(-1)
    end
  end
end
