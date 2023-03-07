class Api::V1::FavoritesController < ApplicationController
  before_action :find_user
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_api_key

  def create
    if @user.favorites.create!(favorite_params)
      render json: { success: "Favorite added successfully" }, status: 201
    end
  end

  def index
    render json: FavoriteSerializer.new(@user.favorites)
  end

  private

    def find_user
      @user = User.find_by!(api_key: params[:api_key])
    end

    def favorite_params
      params.permit(:country, :recipe_link, :recipe_title)
    end

    def invalid_api_key(exception)
      render json: ErrorSerializer.new(exception).serialize, status: 404
    end
end