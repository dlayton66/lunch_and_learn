class RecipesService
  def self.conn
    Faraday.new(
      url: 'https://api.edamam.com/api/recipes/v2/',
      params: {
        app_id: ENV['APP_ID'],
        app_key: ENV['APP_KEY'],
        type: 'public'
      }
    )
  end

  def self.get_recipes(country)
    conn.get('', q: country)
  end
end