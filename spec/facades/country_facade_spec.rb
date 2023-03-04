require 'rails_helper'

RSpec.describe CountryFacade, :vcr do
  describe '.load_random_country' do
    it 'loads random country from CountryService' do
      country = CountryFacade.load_random_country

      expect(country).to be_a(String)
    end
  end
end