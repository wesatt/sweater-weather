# frozen_string_literal: true

class YelpFacade
  def self.get_restaurants(location, food_type)
    json_hash = YelpService.get_restaurants(location, food_type)
    json_hash[:businesses].map do |business|
      Munchie.new(business)
    end
  end
end
