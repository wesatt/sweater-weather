# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/v1/road_trip api endpoints', :vcr, type: :request do
  describe 'POST api/v1/road_trip' do
    it 'authenticates the api_key and returns a json of Roadtrip info' do
      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      params = {
        origin: 'Denver,CO',
        destination: 'Pueblo,CO',
        api_key: '35f291ad58d0ac2c5a6275cbe56eb4d3'
      }
      user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
      user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)

      expect(response).to have_http_status(200)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body.keys).to include(:data)

      data = body[:data]
      expect(data.keys).to include(:id, :type, :attributes)
      expect(data.keys.count).to eq(3)
      expect(data[:id]).to eq(nil)
      expect(data[:type]).to eq('roadtrip')

      attributes = data[:attributes]
      expect(attributes.keys).to include(:start_city, :end_city, :travel_time, :weather_at_eta)
      expect(attributes.keys.count).to eq(4)
      expect(attributes[:start_city]).to eq('Denver,CO')
      expect(attributes[:end_city]).to eq('Pueblo,CO')
      expect(attributes[:travel_time]).to be_a(String)

      weather_at_eta = attributes[:weather_at_eta]
      expect(weather_at_eta.keys).to include(:temperature, :conditions)
      expect(weather_at_eta.keys.count).to eq(2)
      expect(weather_at_eta[:temperature]).to be_a(Float)
      expect(weather_at_eta[:conditions]).to be_a(String)
    end
  end
end
