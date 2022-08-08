# frozen_string_literal: true

class YelpService < BaseService
  def self.get_restaurants(location, food_type)
    response = yelp_conn.get("/v3/businesses/search?term=restaurants&location=#{location}&categories=#{food_type}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
