class CountryService < BaseService
  def self.conn
    Faraday.new(
      url: 'https://restcountries.com/v3.1/'
    )
  end

  def self.get_countries
    conn.get('all')
  end

  def self.get_country(country)
    conn.get("name/#{country}")
  end
end