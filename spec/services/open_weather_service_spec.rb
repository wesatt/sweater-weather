require 'rails_helper'

RSpec.describe OpenWeatherService, :vcr do
  describe 'OpenWeather connection' do
    it 'establishes a connection to the OpenWeather API' do
      expect(OpenWeatherService.weather_conn).to be_a(Faraday::Connection)
    end
  end
end
