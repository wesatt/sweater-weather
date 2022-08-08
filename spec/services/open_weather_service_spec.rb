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

      binding.pry

      expect(response.keys).to include(:current, :daily, :hourly)
    end
  end
end
