require 'rails_helper'

RSpec.describe TouristSightsService, :vcr do
  it "gets tourist sights for given latitude and longitude" do
    response = TouristSightsService.get_tourist_sights([48.87, 2.33])

    expect(response.status).to eq(200)

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response[:type]).to eq('FeatureCollection')
    expect(parsed_response[:features][0][:type]).to eq('Feature')
    expect(parsed_response[:features][0][:properties][:name]).to be_a(String)
    expect(parsed_response[:features][0][:properties][:formatted]).to be_a(String)
    expect(parsed_response[:features][0][:properties][:place_id]).to be_a(String)
  end
end