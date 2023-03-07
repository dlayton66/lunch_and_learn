class LearningResources
  attr_reader :id, :country, :video, :images
  
  def initialize(learning_resources_info)
    @id = nil
    @country = learning_resources_info[:country]
    @video = learning_resources_info[:video]
    @images = learning_resources_info[:images]
  end
end