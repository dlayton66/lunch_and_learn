require 'rails_helper'

RSpec.describe 'recipes request', :vcr do
  describe 'recipes index' do
    describe 'country query param' do
      before { get api_v1_recipes_path, params: { country: 'Norway'} }

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

    describe 'edge cases' do
      context 'no params passed' do
        it 'picks random country using CountriesService' do
          allow(CountriesFacade).to receive(:load_random_country).and_return("Caribbean Netherlands")
          get api_v1_recipes_path

          expect(response).to be_successful

          recipes = JSON.parse(response.body, symbolize_names: true)[:data]
  
          expect(recipes).to be_an(Array)
  
          recipes.each do |recipe|
            expect(recipe[:id]).to be(nil)
            expect(recipe[:type]).to eq('recipe')
  
            expect(recipe[:attributes][:title]).to be_a(String)
            expect(recipe[:attributes][:url]).to be_a(String)
            expect(recipe[:attributes][:country]).to be_a(String)
            expect(recipe[:attributes][:image]).to be_a(String)
          end
        end
      end

      context 'country param is empty string' do
        it 'returns a hash with empty array' do
          get api_v1_recipes_path, params: { country: '' }
          
          recipes = JSON.parse(response.body, symbolize_names: true)[:data]

          expect(recipes).to eq([])
        end
      end

      context 'no results found' do
        it 'returns a hash with empty array' do
          get api_v1_recipes_path, params: { country: 'jfgoisajdfbgoinaisjdfo' }

          recipes = JSON.parse(response.body, symbolize_names: true)[:data]
          expect(recipes).to eq([])
        end
      end
    end
  end
end