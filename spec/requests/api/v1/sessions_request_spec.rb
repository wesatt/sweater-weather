# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/v1/sessions api endpoints', :vcr, type: :request do
  describe 'POST api/v1/sessions' do
    it 'finds the user and returns a json with their email and api_key' do
      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      params = {
        email: 'yogi@picnics.gov',
        password: 'noturaveragebear'
      }
      user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
      user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

      post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

      expect(response).to have_http_status(200)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body.keys).to include(:data)

      data = body[:data]
      expect(data.keys).to include(:id, :type, :attributes)
      expect(data.keys.count).to eq(3)
      expect(data[:id].to_i).to eq(user.id)
      expect(data[:type]).to eq('users')

      attributes = data[:attributes]
      expect(attributes.keys).to include(:email, :api_key)
      expect(attributes.keys.count).to eq(2)
      expect(attributes[:email]).to eq('yogi@picnics.gov')
      expect(attributes[:api_key]).to eq('35f291ad58d0ac2c5a6275cbe56eb4d3')
    end

    describe 'SAD PATH credentials do not match records' do
      it 'returns an error if password does not match stored records' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          email: 'yogi@picnics.gov',
          password: 'notyouraveragebear'
        }
        user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
        user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

        post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

        expect(response).to have_http_status(401)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq('Provided credentials are invalid')
      end

      it 'returns an error if email does not match stored records' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          email: 'yogi@picnics.net',
          password: 'noturaveragebear'
        }
        user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
        user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

        post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

        expect(response).to have_http_status(401)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq('Provided credentials are invalid')
      end
    end
  end
end
