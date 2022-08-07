# frozen_string_literal: true

class MapQuestFacade
  def self.get_coordinates(location)
    json = MapQuestService.get_coordinates(location)
    json[:results].first[:locations].first[:latLng]
  end
end
