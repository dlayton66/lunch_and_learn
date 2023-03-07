require 'rails_helper'

RSpec.describe UnsplashService, :vcr do
  describe '.find_images' do
    context 'country passed in' do
      it 'finds the first 10 images by country keyword' do
        response = UnsplashService.find_images('Laos')

        expect(response.status).to eq(200)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:results]).to be_an(Array)

        images = parsed_response[:results]
        images.each do |image|
          expect(image[:alt_description]).to be_a(String) if image[:alt_description]
          expect(image[:urls][:raw]).to be_a(String)
        end
      end
    end
  end
end