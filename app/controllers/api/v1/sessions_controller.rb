class Api::V1::SessionsController < ApplicationController
  rescue_from BadPasswordError, with: :bad_password_response
  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      render json: UserSerializer.new(user)
    else
      raise BadPasswordError
    end
  end

  private

    def bad_password_response(exception)
      render json: ErrorSerializer.new(exception).serialize, status: :bad_request
    end
end