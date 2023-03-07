class UnsplashService
  def self.conn
    Faraday.new(
      url: 'https://api.unsplash.com/',
      headers: {
        'Accept-Version': 'v1',
        Authorization: "Client-ID #{ENV['UNSPLASH_ACCESS_KEY']}"
      }
    )
  end

  def self.find_images(country)
    conn.get(
      'search/photos',
      {
        query: country
      }
    )
  end
end