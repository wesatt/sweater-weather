# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Munchie do
  it 'exists and has attributes' do
    data = {}
    munchie = Munchie.new(data)

    expect(munchie).to be_a(Munchie)
    expect(munchie.name).to eq('')
    expect(munchie.address).to eq('')
  end
end
