require 'rails_helper'

RSpec.describe Item, type: :model do
  before { @item = FactoryGirl.build(:item) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:done) }
  it { is_expected.to respond_to(:bucketlist) }

  it "validates item with valid credentials" do
    expect(@item).to be_valid
  end
end
