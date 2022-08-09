# frozen_string_literal: true

class RoadTripSerializer
  def self.format_roadtrip(from, to, route, arrival_forecast)
    weather = determine_weather(route, arrival_forecast)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: from,
          end_city: to,
          travel_time: route.travel_time,
          weather_at_eta: {
            temperature: weather[:temperature],
            conditions: weather[:conditions]
          }
        }
      }
    }
  end

  def self.format_impossible_route(from, to)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: from,
          end_city: to,
          travel_time: 'impossible route',
          weather_at_eta: {
            temperature: '',
            conditions: ''
          }
        }
      }
    }
  end

  def self.determine_weather(route, arrival_forecast)
    time = route.time_hash
    days = time[:days]
    hours = time[:hours]
    if days >= 2
      w = arrival_forecast.daily_formatted(days + 1).last
      { temperature: w[:max_temp], conditions: w[:conditions] }
    else
      total_hours = (days * 24) + hours
      arrival_forecast.hourly_formatted(total_hours + 1).last
    end
  end
end
