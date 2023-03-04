class Recipe
  attr_reader :id, :title, :url, :country, :image

  def initialize(recipe_info, country)
    @id = nil
    @title = recipe_info[:recipe][:label]
    @url = recipe_info[:recipe][:url]
    @country = country
    @image = recipe_info[:recipe][:image]
  end
end