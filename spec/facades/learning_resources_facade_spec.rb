require 'rails_helper'

RSpec.describe LearningResourcesFacade, :vcr do
  describe '.load_learning_resources' do
    it 'loads learning resources into poro' do
      learning_resources = LearningResourcesFacade.load_learning_resources('Laos')
      expect(learning_resources).to be_a(LearningResources)
    end
  end
end