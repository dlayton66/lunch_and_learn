require 'rails_helper'

RSpec.describe 'sessions request' do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
  let!(:user) { create(:user) }

  describe 'create' do
    it 'returns user info if password is correct' do
      payload = {
        email: user.email,
        password: user.password
      }

      post api_v1_sessions_path, headers: headers, params: JSON.generate(payload)

      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:id]).to be_a(String)
      expect(parsed_response[:data][:type]).to eq('user')

      expect(parsed_response[:data][:attributes][:name]).to eq(user.name)
      expect(parsed_response[:data][:attributes][:email]).to eq(user.email)
      expect(parsed_response[:data][:attributes][:api_key]).to be_a(String)    
    end
    
    describe 'sad path' do
      it 'returns error if password is incorrect' do
        payload = {
          email: user.email,
          password: 'GOD'
        }
  
        post api_v1_sessions_path, headers: headers, params: JSON.generate(payload)

        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors][0][:detail]).to eq("Wrong password")
      end
    end
  end
end