# frozen_string_literal: true

class ForecastSerializer
  def self.format_forecast(forecast)
    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: forecast.current_formatted,
          daily_weather: forecast.daily_formatted(5),
          hourly_weather: forecast.hourly_formatted(8)
        }
      }
    }
  end
end
