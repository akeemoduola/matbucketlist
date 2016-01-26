class ApplicationController < ActionController::API
  before_action :authenticate_request!
  attr_reader :current_user

  # When an error occurs, respond with the proper private method below
  rescue_from AuthenticationTimeoutError, with: :authentication_timeout
  rescue_from NotAuthenticatedError, with: :user_not_authenticated

  protected

  # This method gets the current user based on the user_id included
  # in the Authorization header (json web token).
  def authenticate_request!
    fail NotAuthenticatedError unless user_id_included_in_auth_token?
    @current_user = User.find(decoded_auth_token[0]["user_id"])
    activate(@current_user)
  rescue JWT::ExpiredSignature
    raise AuthenticationTimeoutError
  rescue JWT::VerificationError, JWT::DecodeError
    raise NotAuthenticatedError
  end

  private

  # Authentication Related Helper Methods
  # ------------------------------------------------------------
  def user_id_included_in_auth_token?
    http_auth_token && decoded_auth_token && decoded_auth_token[0]["user_id"]
  end

  # Decode the authorization header token and return the payload
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_token)
  end

  def http_auth_token
    @http_auth_token ||= if request.headers['Authorization'].present?
                           request.headers['Authorization'].split(' ').last
                         end
  end

  # Check if user is logged in#
  def activate(user)
    unless user && user.active?
      render json: { Error: "You must login first" }, status: 401
    end
  end

  # Helper Methods for responding to errors#
  def authentication_timeout
    render json: { errors: ['Token has expired. Re-login for a new token.'] }, status: 419
  end
  def user_not_authenticated
    render json: { errors: ["You are not authorized to perform this action."] }, status: :unauthorized
  end
end
