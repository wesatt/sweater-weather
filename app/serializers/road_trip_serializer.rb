# frozen_string_literal: true

class RoadTripSerializer
  def self.format_roadtrip(from, to, directions, arrival_weather)
    time_string = directions.travel_time
    if time_string == 'impossible route'
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
    else
      weather = determine_weather(directions, arrival_weather)
      {
        data: {
          id: nil,
          type: 'roadtrip',
          attributes: {
            start_city: from,
            end_city: to,
            travel_time: time_string,
            weather_at_eta: {
              temperature: weather[:temperature],
              conditions: weather[:conditions]
            }
          }
        }
      }
    end
  end

  def self.determine_weather(directions, arrival_weather)
    time = directions.time_hash
    days = time[:days]
    hours = time[:hours]
    if days >= 2
      w = arrival_weather.daily_formatted(days + 1).last
      { temperature: w[:max_temp], conditions: w[:conditions] }
    # elsif days.positive? || hours.positive?
    #   total_hours = (days * 24) + hours
    #   arrival_weather.hourly_formatted(total_hours + 1).last
    # else
    #   arrival_weather.current_formatted # needed? OK to just return hourly?
    else
      total_hours = (days * 24) + hours
      arrival_weather.hourly_formatted(total_hours + 1).last
    end
  end
end
