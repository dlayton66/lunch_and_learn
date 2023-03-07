class LearningResourcesFacade
  def self.load_learning_resources(country)
    video_response = YoutubeService.get_mr_history_video(country)
    video_info = BaseService.parse_json(video_response)[:items][0]

    images_response = UnsplashService.find_images(country)
    images_info = BaseService.parse_json(images_response)[:results]

    LearningResources.new(learning_resources_info(country,video_info,images_info))
  end

  private

    def self.images_array(images_info)
      images_info.map do |image_info|
        {
          alt_tag: image_info[:alt_description],
          url: image_info[:urls][:raw]
        }
      end
    end

    def self.learning_resources_info(country, video_info, images_info)
      {
        country: country,
        video: {
          title: video_info[:snippet][:title],
          youtube_video_id: video_info[:id][:videoId]
        },
        images: images_array(images_info)
      }
    end
end