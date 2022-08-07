# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapQuestService, :vcr do
  describe 'MapQuest connection' do
    it 'establishes a connection to the MapQuest API' do
      expect(MapQuestService.map_conn).to be_a(Faraday::Connection)
    end
  end
end
