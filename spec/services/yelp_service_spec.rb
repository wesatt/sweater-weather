# frozen_string_literal: true

require 'rails_helper'

RSpec.describe YelpService, :vcr do
  describe 'Yelp connection' do
    it 'establishes a connection to the Yelp API' do
      expect(YelpService.yelp_conn).to be_a(Faraday::Connection)
    end
  end

  describe '.get_restaurants(location, food_type)' do
    it 'returns a json with a list of restaurants in a given location that matches the food type' do
      response = YelpService.get_restaurants('denver,co', 'chinese')

      binding.pry
      # expect these to fail for now, until I get a working response
      expect(response.keys).to include(:busiinesses)
      results = response[:results]
      expect(results).to be_a(Array)
      expect(results.first.keys).to include(:locations)
      locations = results.first[:locations]
      expect(locations.first.keys).to include(:latLng)
      coordinates = locations.first[:latLng]
      expect(coordinates.keys).to include(:lat, :lng)
      expect(coordinates[:lat]).to be_a(Float)
      expect(coordinates[:lng]).to be_a(Float)
    end
  end
end
