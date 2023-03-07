require 'rails_helper'

RSpec.describe RecipesService, :vcr do
  describe '.get_recipes' do
    it 'gets recipes by country' do
      response = RecipesService.get_recipes('Norway')
  
      expect(response.status).to eq(200)
  
      parsed_response = JSON.parse(response.body, symbolize_names: true)
  
      expect(parsed_response[:hits]).to be_an(Array)
      expect(parsed_response[:hits][0][:recipe][:label]).to be_a(String)
      expect(parsed_response[:hits][0][:recipe][:url]).to be_a(String)
      expect(parsed_response[:hits][0][:recipe][:image]).to be_a(String)
    end
  end
end