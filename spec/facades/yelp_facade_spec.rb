# frozen_string_literal: true

require 'rails_helper'

RSpec.describe YelpFacade, :vcr do
  describe '.get_restaurants(location, food_type)' do
    it 'returns a Munchie PORO for the given location and food type' do
      munchie = YelpFacade.get_restaurants('denver,co', 'chinese')

      expect(munchie).to be_a(Munchie)
      expect(munchie.name).to eq('')
      expect(munchie.address).to eq('')
    end
  end
end
