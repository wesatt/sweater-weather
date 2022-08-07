# frozen_string_literal: true

class OpenWeatherFacade
  def self.get_forecast(lat, lng)
    json = OpenWeatherService.get_forecast(lat, lng)
    Forecast.new(json)
  end
end
