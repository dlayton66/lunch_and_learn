require 'rails_helper'

RSpec.describe CountryService, :vcr do
  it 'gets a list of all countries' do
    response = CountryService.get_countries

    expect(response.status).to eq(200)

    countries = JSON.parse(response.body, symbolize_names: true)

    expect(countries).to be_an(Array)

    countries.each do |country|
      expect(country[:name][:common]).to be_a(String)
    end
  end

  it 'gets info for a country' do
    response = CountryService.get_country('France')

    expect(response.status).to eq(200)

    country = JSON.parse(response.body, symbolize_names: true)

    expect(country[0][:name][:common]).to eq('France')
    expect(country[0][:capital][0]).to eq('Paris')
    expect(country[0][:capitalInfo][:latlng]).to eq([48.87, 2.33])
  end
end