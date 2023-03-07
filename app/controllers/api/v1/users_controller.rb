class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response

  def create
    user = User.create!(user_params)
    render json: UserSerializer.new(user), status: 201
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

    def record_invalid_response(exception)
      render json: ErrorSerializer.new(exception).serialize, status: :bad_request
    end
end