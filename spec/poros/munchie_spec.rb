# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Munchie do
  it 'exists and has attributes' do
    data = { id: 'yUXr2d9pomzJgmbPl8tlZQ',
             alias: 'q-house-denver',
             name: 'Q House',
             image_url: 'https://s3-media2.fl.yelpcdn.com/bphoto/j6qTLzzfT31F92HxwrH0ww/o.jpg',
             is_closed: false,
             url: 'https://www.yelp.com/biz/q-house-denver?adjust_creative=MgIycIDMl67r8ZqXjW1UrQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=MgIycIDMl67r8ZqXjW1UrQ',
             review_count: 226,
             categories: [{ alias: 'chinese', title: 'Chinese' }],
             rating: 4.5,
             coordinates: { latitude: 39.7403344229824, longitude: -104.947235575533 },
             transactions: %w[pickup delivery],
             price: '$$',
             location: { address1: '3421 E Colfax Ave',
                         address2: '',
                         address3: nil,
                         city: 'Denver',
                         zip_code: '80206',
                         country: 'US',
                         state: 'CO',
                         display_address: ['3421 E Colfax Ave', 'Denver, CO 80206'] },
             phone: '+17207298887',
             display_phone: '(720) 729-8887',
             distance: 2038.887140689118 }
    munchie = Munchie.new(data)

    expect(munchie).to be_a(Munchie)
    expect(munchie.name).to eq('Q House')
    expect(munchie.address).to eq('3421 E Colfax Ave, Denver, CO 80206')
  end
end
