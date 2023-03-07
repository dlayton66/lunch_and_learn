class LearningResourceFacade
  def self.load_learning_resource(country)
    video_response = YoutubeService.get_mr_history_video(country)
    video_info = BaseService.parse_json(video_response)[:items][0]

    images_response = UnsplashService.find_images(country)
    images_info = BaseService.parse_json(images_response)[:results]

    LearningResource.new(learning_resource_info(country,video_info,images_info))
  end

  private

    def self.learning_resource_info(country, video_info, images_info)
      {
        country: country,
        video: video_hash(video_info),
        images: images_array(images_info)
      }
    end

    def self.video_hash(video_info)
      return {} unless video_info
      {
        title: video_info[:snippet][:title],
        youtube_video_id: video_info[:id][:videoId]
      }
    end

    def self.images_array(images_info)
      images_info.map do |image_info|
        {
          alt_tag: image_info[:alt_description],
          url: image_info[:urls][:raw]
        }
      end
    end
end