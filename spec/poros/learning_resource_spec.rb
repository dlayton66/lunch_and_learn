require 'rails_helper'

RSpec.describe LearningResource, :vcr do
  it 'has attributes' do
    learning_resource = LearningResourceFacade.load_learning_resource('Laos')

    expect(learning_resource.country).to eq('Laos')
    expect(learning_resource.id).to be_nil

    expect(learning_resource.video).to be_a(Hash)
    expect(learning_resource.video[:title]).to be_a(String)
    expect(learning_resource.video[:youtube_video_id]).to be_a(String)

    expect(learning_resource.images).to be_an(Array)
    learning_resource.images.each do |image|
      expect(image[:alt_tag]).to be_a(String) if image[:alt_tag]
      expect(image[:url]).to be_a(String)
    end
  end
end