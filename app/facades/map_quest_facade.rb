# frozen_string_literal: true

class MapQuestFacade
  def self.get_coordinates(location)
    json = MapQuestService.get_coordinates(location)
    Location.new(json[:results].first[:locations].first[:latLng])
  end

  def self.get_directions(from, to)
    json = MapQuestService.get_directions(from, to)
    Route.new(json[:route])
  end
end
