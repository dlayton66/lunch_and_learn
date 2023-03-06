class TouristSightsService < BaseService
  def self.conn
    Faraday.new(
      url: 'https://api.geoapify.com/v2/',
      params: { apiKey: ENV['PLACES_API_KEY']}
    )
  end

  def self.get_tourist_sights(latlng)
    conn.get(
      'places',
      { 
        categories: 'tourism.sights',
        filter: "circle:#{latlng[1]},#{latlng[0]},1000"
      }
    )
  end
end