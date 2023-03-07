require 'rails_helper'

RSpec.describe 'sessions request' do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
  let!(:user) { 
    User.create(
      name: "Drew",
      email: "drew@drew.com",
      password: "password123",
      password_confirmation: "password123"
    )
  }

  describe 'create' do
    it 'returns user info if password is correct' do
      payload = {
        email: 'drew@drew.com',
        password: 'password123'
      }

      post api_v1_sessions_path, headers: headers, params: JSON.generate(session: payload)

      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:id]).to be_a(String)
      expect(parsed_response[:data][:type]).to eq('user')

      expect(parsed_response[:data][:attributes][:name]).to eq('Drew')
      expect(parsed_response[:data][:attributes][:email]).to eq('drew@drew.com')
      expect(parsed_response[:data][:attributes][:api_key]).to be_a(String)    
    end
    
    describe 'sad path' do
      it 'returns error if password is incorrect' do
        payload = {
          email: 'drew@drew.com',
          password: 'GOD'
        }
  
        post api_v1_sessions_path, headers: headers, params: JSON.generate(session: payload)

        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors][0][:detail]).to eq("Wrong password")
      end
    end
  end
end