# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/v1/users api endpoints', :vcr, type: :request do
  describe 'POST api/v1/users' do
    it 'creates a new user and returns a json with an assigned api_key' do
      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      params = {
        email: 'cool-guy@dude.net',
        password: 'password',
        password_confirmation: 'password'
      }
      post 'api/v1/users', headers: headers, params: params

      expect(response).to have_http_status(201)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body.keys).to include(:data)

      data = body[:data]
      expect(data.keys).to include(:id, :type, :attributes)
      expect(data.keys.count).to eq(3)
      expect(data[:id].to_i).to be_a(Integer)
      expect(data[:type]).to eq('users')

      attributes = data[:attributes]
      expect(attributes.keys).to include(:email, :api_key)
      expect(attributes.keys.count).to eq(2)
      expect(attributes[:email]).to eq('cool-guy@dude.net')
      expect(attributes[:api_key]).to be_a(String)
    end
  end
end
