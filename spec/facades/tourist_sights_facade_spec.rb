require 'rails_helper'

RSpec.describe TouristSightsFacade, :vcr do
  it "loads tourist sights into poros for a given country's capital" do
    tourist_sights = TouristSightsFacade.load_tourist_sights('France')

    expect(tourist_sights).to be_an(Array)
    tourist_sights.each do |tourist_sight|
      expect(tourist_sight).to be_a(TouristSight)
    end
  end
end