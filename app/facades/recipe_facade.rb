class RecipeFacade
  def self.load_recipes(country)
    response = RecipeService.get_recipes(country)
    parsed_response = RecipeService.parse_json(response)
    recipes = parsed_response[:hits]

    recipes.map do |recipe|
      Recipe.new(recipe, country)
    end
  end
end