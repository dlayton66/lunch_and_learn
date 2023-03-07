require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'relationships' do
    it { should have_many(:favorites) }
  end

  describe 'callbacks' do
    describe '.generate_api_key' do
      it 'generates an api key on user creation' do
        user = User.create!(
          name: 'Drew', 
          email: 'drew@drew.com',
          password: 'password123',
          password_confirmation: 'password123'
        )

        expect(user.api_key).to be_a(String)
      end
    end
  end
end