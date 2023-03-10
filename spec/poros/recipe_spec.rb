require 'rails_helper'

RSpec.describe Recipe, :vcr do
  it 'has attributes' do
    recipe = RecipesFacade.load_recipes('Norway')[0]

    expect(recipe.id).to be_nil
    expect(recipe.title).to be_a(String)
    expect(recipe.url).to be_a(String)
    expect(recipe.country).to eq('Norway')
    expect(recipe.image).to be_a(String)
  end
end