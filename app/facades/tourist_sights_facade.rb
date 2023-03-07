class TouristSightsFacade
  def self.load_tourist_sights(country)
    capital = CountriesFacade.find_capital(country)
    response = TouristSightsService.get_tourist_sights(capital[:latlng])
    tourist_sights = BaseService.parse_json(response)[:features]

    tourist_sights.map do |tourist_sight_info|
      TouristSight.new(tourist_sight_info)
    end
  end
end