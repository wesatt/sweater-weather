# frozen_string_literal: true

class MapQuestService < BaseService
  def self.get_coordinates(location)
    response = map_conn.get("/geocoding/v1/address?location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_directions(from, to)
    response = map_conn.get("/directions/v2/route?from=#{from}&to=#{to}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
