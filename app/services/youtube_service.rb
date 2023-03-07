class YoutubeService
  def self.conn
    Faraday.new(
      url: 'https://youtube.googleapis.com/youtube/v3/',
      params: 
      {
        part: 'snippet',
        key: ENV['YOUTUBE_API_KEY']
      }
    )
  end

  def self.get_mr_history_video(country)
    conn.get(
      'search',
      {
        q: country,
        maxResults: 1,
        channelId: 'UCluQ5yInbeAkkeCndNnUhpw'
      }
    )
  end
end