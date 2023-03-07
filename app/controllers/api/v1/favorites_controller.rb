class Api::V1::FavoritesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_api_key

  def create
    user = User.find_by!(api_key: params[:api_key])
    if user.favorites.create!(favorite_params)
      render json: { success: "Favorite added successfully" }, status: 201
    end
  end

  private

    def favorite_params
      params.permit(:country, :recipe_link, :recipe_title)
    end

    def invalid_api_key(exception)
      render json: ErrorSerializer.new(exception).serialize, status: 404
    end
end