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

  # def self.current_weather(current)
  #   {
  #     datetime: Time.at(current[:dt]).to_datetime,
  #     sunrise: Time.at(current[:sunrise]).to_datetime,
  #     sunset: Time.at(current[:sunset]).to_datetime,
  #     temperature: current[:temp],
  #     feels_like: current[:feels_like],
  #     humidity: current[:humidity],
  #     uvi: current[:uvi],
  #     visibility: current[:visibility],
  #     conditions: current[:weather].first[:description],
  #     icon: current[:weather].first[:icon]
  #   }
  # end

  # def self.daily_weather(dailies)
  #   dailies.map do |day|
  #     {
  #       date: Time.at(day[:dt]).to_date,
  #       sunrise: Time.at(day[:sunrise]).to_datetime,
  #       sunset: Time.at(day[:sunset]).to_datetime,
  #       max_temp: day[:temp][:max],
  #       min_temp: day[:temp][:min],
  #       conditions: day[:weather].first[:description],
  #       icon: day[:weather].first[:icon]
  #     }
  #   end
  # end

  # def self.hourly_weather(hourlies)
  #   hourlies.map do |hour|
  #     {
  #       time: Time.at(hour[:dt]).strftime('%H:%M:%S'),
  #       temperature: hour[:temp],
  #       conditions: hour[:weather].first[:description],
  #       icon: hour[:weather].first[:icon]
  #     }
  #   end
  # end
end
