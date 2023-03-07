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
        let(:payload) { {
          api_key: 'bad_key',
          country: "Thailand",
          recipe_link: "https://www.recipelink.com",
          recipe_title: "Crab Fried Rice"
        } }

        it 'returns an error' do
          post api_v1_favorites_path, headers: headers, params: JSON.generate(payload)

          expect(response.status).to eq(404)
          
          parsed_response = JSON.parse(response.body, symbolize_names: true)

          expect(parsed_response[:errors][0][:detail]).to eq("Couldn't find User")
        end
      end
    end
  end
end