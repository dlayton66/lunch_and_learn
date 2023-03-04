class CountryFacade
  def self.load_random_country
    response = CountryService.get_countries
    parsed_response = CountryService.parse_json(response)
    parsed_response.sample[:name][:common]
  end
end