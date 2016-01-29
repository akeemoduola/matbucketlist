require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:generate_jwt_token) }

  it "validates user with valid credentials" do
    expect(@user).to be_valid
  end

  before { @user1 = FactoryGirl.build(:user, name: nil) }
  it "invalidates user with invalid credentials" do
    expect(@user1).not_to be_valid
  end
end
