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

      expect(response.keys).to include(:businesses, :total, :region)
      expect(response.keys.count).to eq(3)

      businesses = response[:businesses]
      expect(businesses).to be_a(Array)

      business = businesses.first
      expect(business.keys).to include(:name, :location)
      expect(business[:name]).to be_a(String)
      expect(business[:location][:display_address]).to be_a(Array)

      full_address = business[:location][:display_address].join(', ')
      expect(full_address).to be_a(String)
    end
  end
end
