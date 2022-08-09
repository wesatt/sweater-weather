# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapQuestService, :vcr do
  describe 'MapQuest connection' do
    it 'establishes a connection to the MapQuest API' do
      expect(MapQuestService.map_conn).to be_a(Faraday::Connection)
    end
  end

  describe '.get_coordinates(location)' do
    it 'returns a json with coordinates for the given address' do
      response = MapQuestService.get_coordinates('denver,co')

      expect(response.keys).to include(:results)
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

  describe '.get_directions(from, to)' do
    it 'returns a json with directions for the locations provided' do
      response = MapQuestService.get_directions('pueblo,co', 'denver,co')

      expect(response.keys).to include(:route)
      route = response[:route]
      expect(route.keys).to include(:time, :locations)
      expect(route[:time]).to be_a(Integer)
      locations = route[:locations]
      expect(locations).to be_a(Array)
      destination = locations.last
      expect(destination.keys).to include(:displayLatLng, :latLng, :adminArea5, :adminArea3)
      expect(destination[:adminArea5]).to be_a(String) # city
      expect(destination[:adminArea3]).to be_a(String) # state
      display_lat_lng = destination[:displayLatLng]
      expect(display_lat_lng.keys).to include(:lng, :lat)
      lat_lng = destination[:latLng]
      expect(lat_lng.keys).to include(:lng, :lat)
    end
  end
end
