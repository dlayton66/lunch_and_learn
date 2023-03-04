require 'rails_helper'

RSpec.describe 'recipe facade', :vcr do
  it 'loads recipes into poros' do
    recipes = RecipeFacade.load_recipes('Norway')

    expect(recipes).to be_an(Array)
    recipes.each do |recipe|
      expect(recipe.class).to be(Recipe)
    end
  end
end