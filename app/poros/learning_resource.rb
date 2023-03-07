class LearningResource
  attr_reader :id, :country, :video, :images

  def initialize(learning_resource_info)
    @id = nil
    @country = learning_resource_info[:country]
    @video = learning_resource_info[:video]
    @images = learning_resource_info[:images]
  end
end