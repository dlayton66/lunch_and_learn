require 'rails_helper'

RSpec.describe LearningResourceFacade, :vcr do
  describe '.load_learning_resource' do
    it 'loads learning resource into poro' do
      learning_resource = LearningResourceFacade.load_learning_resource('Laos')
      expect(learning_resource).to be_a(LearningResource)
    end
  end
end