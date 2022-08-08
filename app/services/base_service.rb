# frozen_string_literal: true

class BaseService
  def self.map_conn
    Faraday.new('http://www.mapquestapi.com') do |req|
      req.params['key'] = ENV['map_quest_api_key']
    end
  end

  def self.weather_conn
    Faraday.new('https://api.openweathermap.org/data/2.5/') do |req|
      req.params['appid'] = ENV['open_weather_api_key']
    end
  end

  def self.yelp_conn
    Faraday.new('https://api.yelp.com') do |req|
      req.headers['Authorization'] = ENV['yelp_api_key']
    end
  end
end
