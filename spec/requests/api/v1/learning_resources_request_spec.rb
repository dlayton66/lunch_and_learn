require 'rails_helper'

RSpec.describe 'learning resources request', :vcr do
  describe 'index' do
    context 'country query param' do
      it 'returns learning resource for a country' do
        get api_v1_learning_resources_path(country: 'Laos')

        expect(response).to be_successful

        learning_resource = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(learning_resource[:id]).to be_nil
        expect(learning_resource[:type]).to eq('learning_resource')
        expect(learning_resource[:attributes][:country]).to eq('Laos')
        expect(learning_resource[:attributes][:video]).to be_a(Hash)
        expect(learning_resource[:attributes][:video][:title]).to be_a(String)
        expect(learning_resource[:attributes][:video][:youtube_video_id]).to be_a(String)
        expect(learning_resource[:attributes][:images]).to be_an(Array)
        expect(learning_resource[:attributes][:images].count).to eq(10)

        learning_resource[:attributes][:images].each do |image|
          expect(image[:alt_tag]).to be_a(String) if image[:alt_tag]
          expect(image[:url]).to be_a(String)
        end
      end
    end
  end
end