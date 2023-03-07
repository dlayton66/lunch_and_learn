require 'rails_helper'

RSpec.describe LearningResources, :vcr do
  it 'has attributes' do
    learning_resources = LearningResourcesFacade.load_learning_resources('Laos')

    expect(learning_resources).to be_a(LearningResources)
    expect(learning_resources.country).to eq('Laos')
    expect(learning_resources.id).to be_nil

    expect(learning_resources.video).to be_a(Hash)
    expect(learning_resources.video[:title]).to be_a(String)
    expect(learning_resources.video[:youtube_video_id]).to be_a(String)

    expect(learning_resources.images).to be_an(Array)
    learning_resources.images.each do |image|
      expect(image[:alt_tag]).to be_a(String) if image[:alt_tag]
      expect(image[:url]).to be_a(String)
    end
  end
end