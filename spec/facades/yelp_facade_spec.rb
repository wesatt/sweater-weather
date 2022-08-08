# frozen_string_literal: true

require 'rails_helper'

RSpec.describe YelpFacade, :vcr do
  describe '.get_restaurants(location, food_type)' do
    it 'returns a Munchie PORO for the given location and food type' do
      munchies = YelpFacade.get_restaurants('denver,co', 'chinese')

      munchie = munchies.first
      expect(munchie).to be_a(Munchie)
      expect(munchie.name).to be_a(String)
      expect(munchie.address).to be_a(String)
    end
  end
end
