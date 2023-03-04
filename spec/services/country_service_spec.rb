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
end