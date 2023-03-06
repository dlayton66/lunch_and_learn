class CountriesFacade
  def self.load_random_country
    response = CountriesService.get_countries
    parsed_response = CountriesService.parse_json(response)
    parsed_response.sample[:name][:common]
  end

  def self.find_capital(country)
    response = CountriesService.get_country(country)
    parsed_response = CountriesService.parse_json(response)

    {
      name: parsed_response[0][:capital][0],
      latlng: parsed_response[0][:capitalInfo][:latlng]
    }
  end
end