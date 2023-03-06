require 'rails_helper'

RSpec.describe YoutubeService, :vcr do
  describe '.get_mr_history_video' do
    context 'country passed in' do
      it 'gets one related video from Mr. History channel' do
        response = YoutubeService.get_mr_history_video('Laos')

        expect(response.status).to eq(200)
        
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:kind]).to eq('youtube#searchListResponse')
        expect(parsed_response[:items].count).to eq(1)

        video = parsed_response[:items][0]

        expect(video[:kind]).to eq("youtube#searchResult")
        expect(video[:snippet][:title]).to eq('A Super Quick History of Laos')
        expect(video[:id][:videoId]).to eq('uw8hjVqxMXw')
      end
    end
  end
end