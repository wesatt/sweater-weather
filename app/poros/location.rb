# frozen_string_literal: true

class Location
  attr_reader :lat,
              :lng

  def initialize(data)
    @lat = data[:lat].round(2)
    @lng = data[:lng].round(2)
  end
end
