require 'rails_helper'

RSpec.describe 'users request' do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  describe 'create' do
    describe 'happy path' do
      let(:payload) { {
        name: "Drew",
        email: "drew@drew.com",
        password: "password123",
        password_confirmation: "password123"
      } }
    
      before { post api_v1_users_path, headers: headers, params: JSON.generate(user: payload) }

      it 'creates a user in the database' do
        user = User.last
  
        expect(user.name).to eq('Drew')
        expect(user.email).to eq('drew@drew.com')
      end

      it 'returns json' do
        expect(response.status).to eq(201)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:data][:id]).to be_a(String)
        expect(parsed_response[:data][:type]).to eq('user')

        expect(parsed_response[:data][:attributes].count).to eq(3)
        expect(parsed_response[:data][:attributes][:name]).to eq('Drew')
        expect(parsed_response[:data][:attributes][:email]).to eq('drew@drew.com')
        expect(parsed_response[:data][:attributes][:api_key]).to be_a(String)
      end
    end

    describe 'sad path' do
      it "doesn't create user if passwords don't match" do
        bad_password_payload = {
          name: "Drew",
          email: "drew@drew.com",
          password: "password123",
          password_confirmation: "GOD"
        }
  
        post api_v1_users_path, headers: headers, params: JSON.generate(user: bad_password_payload)

        expect(response.status).to eq(400)
        expect(User.all).to be_empty

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors][0][:detail]).to eq("Password confirmation doesn't match Password")
      end

      it "doesn't create user if email isn't unique" do
        User.create(
          name: "Drew",
          email: "drew@drew.com",
          password: "password123",
          password_confirmation: "password123"
        )

        bad_email_payload = {
          name: "Drew2",
          email: "drew@drew.com",
          password: "password123",
          password_confirmation: "password123"
        }

        post api_v1_users_path, headers: headers, params: JSON.generate(user: bad_email_payload)

        expect(response.status).to eq(400)
        expect(User.count).to eq(1)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors][0][:detail]).to eq('Email has already been taken')
      end
    end
  end
end