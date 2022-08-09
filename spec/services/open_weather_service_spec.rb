# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenWeatherService, :vcr do
  describe 'OpenWeather connection' do
    it 'establishes a connection to the OpenWeather API' do
      expect(OpenWeatherService.weather_conn).to be_a(Faraday::Connection)
    end
  end

  describe '.get_forecast(coordinates)' do
    it 'returns a json with the forecast for the given coordinates' do
      lat = 39.74
      lng = -104.98
      response = OpenWeatherService.get_forecast(lat, lng)

      expect(response.keys).to include(:current, :daily, :hourly)

      current = response[:current]
      expect(current.keys).to include(
        :dt, :sunrise, :sunset, :temp, :feels_like,
        :humidity, :uvi, :visibility, :weather
      )
      expect(current[:dt]).to be_a(Integer)
      expect(current[:sunrise]).to be_a(Integer)
      expect(current[:sunset]).to be_a(Integer)
      expect(current[:temp]).to be_a(Integer).or be_a(Float)
      expect(current[:feels_like]).to be_a(Integer).or be_a(Float)
      expect(current[:humidity]).to be_a(Integer).or be_a(Float)
      expect(current[:uvi]).to be_a(Integer).or be_a(Float)
      expect(current[:visibility]).to be_a(Integer).or be_a(Float)

      weather = current[:weather].first
      expect(weather.keys).to include(:description, :icon)
      expect(weather[:description]).to be_a(String)
      expect(weather[:icon]).to be_a(String)

      daily = response[:daily]
      expect(daily).to be_a(Array)
      daily.each do |day|
        expect(day.keys).to include(
          :dt, :sunrise, :sunset, :temp, :weather
        )
        expect(day[:dt]).to be_a(Integer)
        expect(day[:sunrise]).to be_a(Integer)
        expect(day[:sunset]).to be_a(Integer)

        temp = day[:temp]
        expect(temp[:max]).to be_a(Integer).or be_a(Float)
        expect(temp[:min]).to be_a(Integer).or be_a(Float)

        weather = day[:weather].first
        expect(weather[:description]).to be_a(String)
        expect(weather[:icon]).to be_a(String)
      end

      hourly = response[:hourly]
      expect(hourly).to be_a(Array)
      hourly.each do |hour|
        expect(hour.keys).to include(:dt, :temp, :weather)
        expect(hour[:dt]).to be_a(Integer)
        expect(hour[:temp]).to be_a(Integer).or be_a(Float)
        weather = hour[:weather].first
        expect(weather.keys).to include(:description, :icon)
        expect(weather[:description]).to be_a(String)
        expect(weather[:icon]).to be_a(String)
      end
    end
  end
end
