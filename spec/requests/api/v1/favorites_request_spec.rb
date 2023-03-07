require 'rails_helper'

RSpec.describe 'favorites request' do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
  let!(:user) {
    User.create(
      name: "Drew",
      email: "drew@drew.com",
      password: "password123",
      password_confirmation: "password123"
    )
  }

  describe 'create' do
    let(:payload) { {
      api_key: user.api_key,
      country: "Thailand",
      recipe_link: "https://www.recipelink.com",
      recipe_title: "Crab Fried Rice"
    } }

    it 'creates a favorite recipe for a user' do

      expect(Favorite.count).to eq(0)

      post api_v1_favorites_path, headers: headers, params: JSON.generate(payload)

      expect(response.status).to eq(201)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:success]).to eq("Favorite added successfully")
      expect(Favorite.count).to eq(1)

      favorite = Favorite.last

      expect(favorite.country).to eq('Thailand')
      expect(favorite.recipe_link).to eq('https://www.recipelink.com')
      expect(favorite.recipe_title).to eq('Crab Fried Rice')
    end

    describe 'sad path' do
      context 'bad api key' do
        it 'returns an error' do
          payload[:api_key] = 'bad_key'
          post api_v1_favorites_path, headers: headers, params: JSON.generate(payload)

          expect(response.status).to eq(404)
          
          parsed_response = JSON.parse(response.body, symbolize_names: true)

          expect(parsed_response[:errors][0][:detail]).to eq("Couldn't find User")
        end
      end
    end
  end

  describe 'index' do
    it 'returns favorites for a user' do
      favorites = create_list(:favorite, 3, user_id: user.id)
      get api_v1_favorites_path, params: { api_key: user.api_key }

      expect(response.status).to be(200)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data]).to be_an(Array)
      parsed_response[:data].each.with_index do |favorite, i|
        expect(favorite[:id]).to eq(favorites[i].id.to_s)
        expect(favorite[:type]).to eq('favorite')

        expect(favorite[:attributes][:country]).to eq(favorites[i].country)
        expect(favorite[:attributes][:recipe_link]).to eq(favorites[i].recipe_link)
        expect(favorite[:attributes][:recipe_title]).to eq(favorites[i].recipe_title)
        expect(favorite[:attributes][:created_at]).to eq(favorites[i].created_at.as_json)
      end
    end

    describe 'edge cases' do
      context 'user has no favorites' do
        it 'data object is empty array' do
          get api_v1_favorites_path, params: { api_key: user.api_key }

          expect(response.status).to be(200)
    
          parsed_response = JSON.parse(response.body, symbolize_names: true)

          expect(parsed_response[:data]).to be_an(Array)
          expect(parsed_response[:data]).to be_empty
        end
      end
    end

    describe 'sad path' do
      context 'bad api key' do
        it 'returns an error' do
          get api_v1_favorites_path, params: { api_key: 'bad_key' }

          expect(response.status).to eq(404)
          
          parsed_response = JSON.parse(response.body, symbolize_names: true)

          expect(parsed_response[:errors][0][:detail]).to eq("Couldn't find User")

        end
      end
    end
  end
end