# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/v1/munchies api endpoints', :vcr, type: :request do
  describe 'GET api/v1/munchies' do
    it 'returns a json with the destination, current weather, and a nearby resaturant of the desired type' do
      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      params = {
        api_key: '35f291ad58d0ac2c5a6275cbe56eb4d3'
      }
      user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
      user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

      get '/api/v1/munchies?location=denver,co&food=chinese', headers: headers, params: params

      expect(response).to have_http_status(200)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body.keys).to include(:data)

      data = body[:data]
      expect(data.keys).to include(:id, :type, :attributes)
      expect(data.keys.count).to eq(3)
      expect(data[:id]).to eq(nil)
      expect(data[:type]).to eq('munchie')

      attributes = data[:attributes]
      expect(attributes.keys).to include(:destination_city, :forecast, :restaurant)
      expect(attributes.keys.count).to eq(3)
      expect(attributes[:destination_city]).to eq('denver,co')

      forecast = attributes[:forecast]
      expect(forecast.keys).to include(:summary, :temperature)
      expect(forecast.keys.count).to eq(2)
      expect(forecast[:summary]).to be_a(String)
      expect(forecast[:temperature]).to be_a(Float)

      restaurant = attributes[:restaurant]
      expect(restaurant.keys).to include(:name, :address)
      expect(restaurant.keys.count).to eq(2)
      expect(restaurant[:name]).to be_a(String)
      expect(restaurant[:address]).to be_a(String)
    end

    describe 'SAD PATHS' do
      it 'will return an error if the location is missing' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          api_key: '35f291ad58d0ac2c5a6275cbe56eb4d3'
        }
        user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
        user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

        get '/api/v1/munchies?food=chinese', headers: headers, params: params

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq('Required parameter is missing')
      end

      it 'will return an error if the location is blank' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          api_key: '35f291ad58d0ac2c5a6275cbe56eb4d3'
        }
        user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
        user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

        get '/api/v1/munchies?location=&food=chinese', headers: headers, params: params

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq('Required parameter is missing')
      end

      it 'will return an error if the food is missing' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          api_key: '35f291ad58d0ac2c5a6275cbe56eb4d3'
        }
        user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
        user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

        get '/api/v1/munchies?location=denver,co', headers: headers, params: params

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq('Required parameter is missing')
      end

      it 'will return an error if the food is blank' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          api_key: '35f291ad58d0ac2c5a6275cbe56eb4d3'
        }
        user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
        user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

        get '/api/v1/munchies?location=denver,co&food=', headers: headers, params: params

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq('Required parameter is missing')
      end

      xit 'will return an error if the location does not exist' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          api_key: '35f291ad58d0ac2c5a6275cbe56eb4d3'
        }
        user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
        user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

        get '/api/v1/munchies?location=denv,cq&food=chinese', headers: headers, params: params

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        # need to update the expected error response
        expect(data[:message]).to eq('Required parameter is missing')
      end

      xit 'will return an error if the food type does not exist' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          api_key: '35f291ad58d0ac2c5a6275cbe56eb4d3'
        }
        user = User.create!(email: 'yogi@picnics.gov', password: 'noturaveragebear')
        user.api_keys.create!(token: '35f291ad58d0ac2c5a6275cbe56eb4d3')

        get '/api/v1/munchies?location=denver,co&food=hardware', headers: headers, params: params

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        # need to update the expected error response
        expect(data[:message]).to eq('Required parameter is missing')
      end
    end
  end
end
