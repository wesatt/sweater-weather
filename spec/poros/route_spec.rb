# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Route do
  it 'exists and has attributes' do
    data = { time: 123_456 }
    route = Route.new(data)

    expect(route).to be_a(Route)
    expect(route.travel_time).to eq('days: 1, hours: 10, minutes: 17')
    time_hash = route.time_hash
    expect(time_hash.keys).to include(:days, :hours, :minutes)
    expect(time_hash[:days]).to eq(1)
    expect(time_hash[:hours]).to eq(10)
    expect(time_hash[:minutes]).to eq(17)

    data2 = {}
    route2 = Route.new(data2)

    expect(route2).to be_a(Route)
    expect(route2.travel_time).to eq('impossible route')
  end
end
