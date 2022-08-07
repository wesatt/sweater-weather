# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/v1/forecast api endpoints', type: :request do
  it 'returns the forecast for ' do
    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    get '/api/v1/forecast?location=denver,co', headers: headers

    # binding.pry

    expect(response).to eq('')
  end
end
