# frozen_string_literal: true

class BaseService
  def self.map_conn
    Faraday.new('http://www.mapquestapi.com')
  end

  def self.weather_conn
    Faraday.new('https://api.openweathermap.org/data/2.5/onecall')
  end
end
