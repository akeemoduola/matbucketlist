require 'rails_helper'

RSpec.describe Bucketlist, type: :model do
  before { @bucketlist = FactoryGirl.build(:bucketlist) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:created_by) }
  it { is_expected.to respond_to(:user) }

  it "validates bucketlist with valid credentials" do
    expect(@bucketlist).to be_valid
  end
end
