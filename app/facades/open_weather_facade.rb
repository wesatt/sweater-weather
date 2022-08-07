# frozen_string_literal: true

class OpenWeatherFacade
  def self.get_forecast(coordinates)
    json = OpenWeatherService.get_forecast(coordinates)
    {
      current: json[:current],
      daily: json[:daily][0..4],
      hourly: json[:hourly][0..7]
    }
  end
end
