require 'rails_helper'

RSpec.describe 'tourist sights request', :vcr do
  describe 'index' do
    context 'country passed in' do
      it 'returns tourist sights for that country' do
        get api_v1_tourist_sights_path(country: 'France')

        expect(response).to be_successful

        tourist_sights = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(tourist_sights).to be_an(Array)

        tourist_sights.each do |tourist_sight|
          expect(tourist_sight[:id]).to be(nil)
          expect(tourist_sight[:type]).to eq('tourist_sight')

          expect(tourist_sight[:attributes][:name]).to be_a(String)
          expect(tourist_sight[:attributes][:address]).to be_a(String)
          expect(tourist_sight[:attributes][:place_id]).to be_a(String)
        end
      end
    end
  end
end