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
        email: 'coolguy@dude.net',
        password: 'password',
        password_confirmation: 'password'
      }
      post '/api/v1/users', headers: headers, params: JSON.generate(params)

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
      expect(attributes[:email]).to eq('coolguy@dude.net')
      expect(attributes[:api_key]).to be_a(String)
    end

    describe 'SAD PATH: returns an error message when a user is unable to be created' do
      it 'passwords do not match' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          email: 'coolguy@dude.net',
          password: '123',
          password_confirmation: '321'
        }
        post '/api/v1/users', headers: headers, params: JSON.generate(params)

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq("Password confirmation doesn't match Password")
      end

      it 'email is already taken' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          email: 'coolguy@dude.net',
          password: '123',
          password_confirmation: '123'
        }
        post '/api/v1/users', headers: headers, params: JSON.generate(params)
        post '/api/v1/users', headers: headers, params: JSON.generate(params)

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq('Email has already been taken')
      end

      it 'email is missing' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          email: '',
          password: '123',
          password_confirmation: '123'
        }
        post '/api/v1/users', headers: headers, params: JSON.generate(params)

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq("Email can't be blank")
      end

      it 'password is missing' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          email: 'coolguy@dude.net',
          password: '',
          password_confirmation: '123'
        }
        post '/api/v1/users', headers: headers, params: JSON.generate(params)

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq("Password can't be blank")
      end

      it 'password confirmation is missing' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }
        params = {
          email: 'coolguy@dude.net',
          password: '123',
          password_confirmation: ''
        }
        post '/api/v1/users', headers: headers, params: JSON.generate(params)

        expect(response).to have_http_status(400)

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body.keys).to include(:data)

        data = body[:data]
        expect(data.keys).to include(:id, :type, :message)
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('error')
        expect(data[:message]).to eq("Password confirmation doesn't match Password")
      end
    end
  end
end
