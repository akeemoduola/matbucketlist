class UsersController < ApplicationController
  skip_before_action :authenticate_request!
# POST /users
def create
  @user = User.new(user_params)
  if @user.save
    render json: @user, status: :created
  else
    render json: @user.errors, status: :unprocessable_entity
  end
end

private
  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:name, :email, :password)
  end
end
