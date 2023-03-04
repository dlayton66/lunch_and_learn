class Api::V1::RecipesController < ApplicationController
  def index
    recipes = RecipeFacade.load_recipes(recipe_params)
    render json: RecipeSerializer.new(recipes)
  end

  private

    def recipe_params
      params.fetch(:country, [])
    end
end