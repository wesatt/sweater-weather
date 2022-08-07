# frozen_string_literal: true

module Api
  module V1
    class ForecastController < ApplicationController
      def index
        coordinates = MapQuestFacade.get_coordinates(params[:location])
        weather = OpenWeatherFacade.get_forecast(coordinates)
        json_hash = ForecastSerializer.format_forecast(weather)
        render json: json_hash
      end
    end
  end
end
