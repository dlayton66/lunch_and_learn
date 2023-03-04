require 'rails_helper'

RSpec.describe 'recipes request', :vcr do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  describe 'recipes index' do
    context 'country passed in' do
      before do
        get api_v1_recipes_path,
          headers: headers,
          params: JSON.generate(country: 'Norway')
      end

      it 'returns recipes for that country' do
        expect(response).to be_successful

        recipes = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(recipes).to be_an(Array)

        recipes.each do |recipe|
          expect(recipe[:id]).to be(nil)
          expect(recipe[:type]).to eq('recipe')

          expect(recipe[:attributes][:title]).to be_a(String)
          expect(recipe[:attributes][:url]).to be_a(String)
          expect(recipe[:attributes][:country]).to eq('Norway')
          expect(recipe[:attributes][:image]).to be_a(String)
        end
      end

      it 'does not return additional attributes' do
        recipes = JSON.parse(response.body, symbolize_names: true)[:data]

        recipes.each do |recipe|
          expect(recipe.count).to eq(3)
          expect(recipe[:attributes].count).to eq(4)
        end
      end
    end
    # context 'no query param' do
    #   get api_v1_recipes_path

      
    # end
  end
end