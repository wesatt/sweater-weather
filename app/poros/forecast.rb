# frozen_string_literal: true

class Forecast
  def initialize(data)
    @data = data
  end

  def current_formatted
    current = @data[:current]
    {
      datetime: Time.at(current[:dt]).to_datetime.to_s,
      sunrise: Time.at(current[:sunrise]).to_datetime.to_s,
      sunset: Time.at(current[:sunset]).to_datetime.to_s,
      temperature: current[:temp].to_f,
      feels_like: current[:feels_like].to_f,
      humidity: current[:humidity],
      uvi: current[:uvi],
      visibility: current[:visibility],
      conditions: current[:weather].first[:description],
      icon: current[:weather].first[:icon]
    }
  end

  def daily_formatted(qty)
    dailies = @data[:daily].first(qty)
    dailies.map do |day|
      {
        date: Time.at(day[:dt]).to_date.to_s,
        sunrise: Time.at(day[:sunrise]).to_datetime.to_s,
        sunset: Time.at(day[:sunset]).to_datetime.to_s,
        max_temp: day[:temp][:max].to_f,
        min_temp: day[:temp][:min].to_f,
        conditions: day[:weather].first[:description],
        icon: day[:weather].first[:icon]
      }
    end
  end

  def hourly_formatted(qty)
    hourlies = @data[:hourly].first(qty)
    hourlies.map do |hour|
      {
        time: Time.at(hour[:dt]).strftime('%H:%M:%S'),
        temperature: hour[:temp].to_f,
        conditions: hour[:weather].first[:description],
        icon: hour[:weather].first[:icon]
      }
    end
  end
end
