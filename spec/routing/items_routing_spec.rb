require "rails_helper"

RSpec.describe Api::V1::ItemsController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/bucketlists/1/items").to route_to("api/v1/items#create", bucketlist_id: "1", format: "json")
    end

    it "routes to #update via PUT" do
      expect(:put => "/bucketlists/1/items/1").to route_to("api/v1/items#update", bucketlist_id: "1", format: "json", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bucketlists/1/items/1").to route_to("api/v1/items#destroy", bucketlist_id: "1", format: "json", :id => "1")
    end

  end
end
