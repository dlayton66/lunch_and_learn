require 'rails_helper'

RSpec.describe TouristSight, :vcr do
  it 'has attributes' do
    tourist_sights = TouristSightsFacade.load_tourist_sights('France')

    tourist_sights.each do |tourist_sight|
      expect(tourist_sight.id).to be_nil
      expect(tourist_sight.name).to be_a(String)
      expect(tourist_sight.address).to be_a(String)
      expect(tourist_sight.place_id).to be_a(String)
    end
  end
end