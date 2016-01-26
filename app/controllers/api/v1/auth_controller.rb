module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_request!, only: :login
      def login
        user = User.find_by_email(params[:email])
        # If the user exists AND the password entered is correct.
        if user && user.authenticate(params[:password])
          user.update_attribute(:active, true)
          render json: { token: user.generate_jwt_token }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      def logout
        @current_user.update_attribute(:active, false) if @current_user
        render json: { message: "You are logged out." }, status: 200
      end
    end
  end
end
