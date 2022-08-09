# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location do
  it 'exists and has attributes' do
    data = { lat: 39.738453, lng: -104.984853 }
    location = Location.new(data)

    expect(location).to be_a(Location)
    expect(location.lat).to eq(39.74)
    expect(location.lng).to eq(-104.98)
  end
end
