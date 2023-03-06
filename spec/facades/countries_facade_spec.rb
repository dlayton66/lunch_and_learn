require 'rails_helper'

RSpec.describe CountriesFacade, :vcr do
  describe '.load_random_country' do
    it 'loads random country from CountriesService' do
      country = CountriesFacade.load_random_country

      expect(country).to be_a(String)
    end
  end

  describe '.find_capital' do
    it 'gets capital and location' do
      capital = CountriesFacade.find_capital('France')

      expect(capital[:name]).to eq('Paris')
      expect(capital[:latlng]).to eq([48.87, 2.33])
    end
  end
end