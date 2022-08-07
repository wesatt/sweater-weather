# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapQuestFacade, :vcr do
  describe '.get_coordinates(location)' do
    it 'returns a location PORO for the given address' do
      location = MapQuestFacade.get_coordinates('denver,co')

      expect(location).to be_a(Location)
      expect(location.lat).to eq(39.738453)
      expect(location.lng).to eq(-104.984853)
    end
  end
end
