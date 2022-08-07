class ForecastSerializer
  def self.format_forecast(weather)
    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: {
            datetime: '',
            sunrise: '',
            sunset: '',
            temperature: '',
            feels_like: '',
            humidity: '',
            uvi: '',
            visibility: '',
            conditions: '',
            icon: ''
          },
          daily_weather: daily_weather(weather),
          hourly_weather: hourly_weather(weather)
        }
      }
    }
  end

  def self.daily_weather(weather)
    {
      date: '',
      sunrise: '',
      sunset: '',
      max_temp: '',
      min_temp: '',
      conditions: '',
      icon: ''
    }
  end

  def self.hourly_weather(weather)
    {
      time: '',
      temperature: '',
      conditions: '',
      icon: ''
    }
  end
end
