# frozen_string_literal: true

class OpenWeatherService < BaseService
  def self.get_forecast(lat, lng)
    response = weather_conn.get(
      "/data/2.5/onecall?lat=#{lat}&lon=#{lng}&exclude=minutely,alerts&units=imperial"
    )
    JSON.parse(response.body, symbolize_names: true)
  end
end
