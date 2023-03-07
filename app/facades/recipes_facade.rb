class RecipesFacade
  def self.load_recipes(country)
    response = RecipesService.get_recipes(country)
    parsed_response = BaseService.parse_json(response)
    recipes = parsed_response[:hits]

    recipes.map do |recipe|
      Recipe.new(recipe, country)
    end
  end
end