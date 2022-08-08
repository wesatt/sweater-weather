# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapQuestFacade, :vcr do
  describe '.get_coordinates(location)' do
    it 'returns a Location PORO for the given address' do
      location = MapQuestFacade.get_coordinates('denver,co')
      # lat = 39.738453
      # lng = -104.984853

      expect(location).to be_a(Location)
      expect(location.lat).to eq(39.74)
      expect(location.lng).to eq(-104.98)
    end
  end

  describe '.get_directions(from, to)' do
    it 'returns a Route PORO for the given origin and destination' do
      route = MapQuestFacade.get_directions('denver,co', 'pueblo,co')

      expect(route).to be_a(Route)
      expect(route.time_hash).to be_a(Hash)
      expect(route.travel_time).to be_a(String)

      impossible_route = MapQuestFacade.get_directions('denver,co', 'london,uk')

      expect(impossible_route).to be_a(Route)
      expect(impossible_route.travel_time).to eq('impossible route')
    end
  end
end
