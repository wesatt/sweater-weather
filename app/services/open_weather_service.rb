# frozen_string_literal: true

class OpenWeatherService < BaseService
  def self.get_forecast(coordinates)
    response = weather_conn.get(
      "onecall?lat=#{coordinates[:lat]}&lon=#{coordinates[:lng]}&exclude=minutely,alerts&units=imperial"
    )
    JSON.parse(response.body, symbolize_names: true)
  end
end
