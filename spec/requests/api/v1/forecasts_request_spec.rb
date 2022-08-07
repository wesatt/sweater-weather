# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/v1/forecast api endpoints', :vcr, type: :request do
  it 'returns the forecast for ' do
    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    get '/api/v1/forecast?location=denver,co', headers: headers

    expect(response).to be_successful
    binding.pry
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body.keys).to include(:data)

    data = response_body[:data]
    expect(data.keys).to include(:id, :type, :attributes)
    expect(data.keys.count).to eq(3) # checks that only the keys above are present
    expect(data[:id]).to eq('null')
    expect(data[:type]).to eq('forecast')
    expect(data[:attributes].keys).to include(:current_weather, :daily_weather, :hourly_weather)
    expect(data[:attributes].keys.count).to eq(3) # checks that only the keys above are present

    current = data[:attributes][:current_weather]
    expect(current.keys).to include(
      :datetime, :sunrise, :sunset, :temperature, :feels_like,
      :humidity, :uvi, :visibility, :conditions, :icon
    )
    expect(current.keys.count).to eq(10) # checks that only the keys above are present
    expect(current[:datetime]).to be_a(String)
    expect(current[:sunrise]).to be_a(String)
    expect(current[:sunset]).to be_a(String)
    expect(current[:temperature]).to be_a(Float)
    expect(current[:feels_like]).to be_a(Float)
    expect(current[:humidity]).to be_a(Integer).or(Float)
    expect(current[:uvi]).to be_a(Integer).or(Float)
    expect(current[:visibility]).to be_a(Integer).or(Float)
    expect(current[:conditions]).to be_a(String)
    expect(current[:icon]).to be_a(String)

    daily = data[:attributes][:daily_weather]
    expect(daily).to be_a(Array)
    expect(daily.count).to eq(5)
    daily.each do |day|
      expect(day.keys).to include(
        :date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon
      )
      expect(day.keys.count).to eq(7) # checks that only the keys above are present
      expect(day[:date]).to be_a(String)
      expect(day[:sunrise]).to be_a(String)
      expect(day[:sunset]).to be_a(String)
      expect(day[:max_temp]).to be_a(Float)
      expect(day[:min_temp]).to be_a(Float)
      expect(day[:conditions]).to be_a(String)
      expect(day[:icon]).to be_a(String)
    end

    hourly = data[:attributes][:hourly_weather]
    expect(hourly).to be_a(Array)
    expect(hourly.count).to eq(8)
    hourly.each do |hour|
      expect(hour.keys).to include(
        :time, :temperature, :conditions, :icon
      )
      expect(hour.keys.count).to eq(4) # checks that only the keys above are present
      expect(hour[:time]).to be_a(String)
      expect(hour[:temperature]).to be_a(Float)
      expect(hour[:conditions]).to be_a(String)
      expect(hour[:icon]).to be_a(String)
    end
  end
end
