# frozen_string_literal: true

class MapQuestService < BaseService
  def self.get_coordinates(location)
    response = map_conn.get("/geocoding/v1/address?location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
