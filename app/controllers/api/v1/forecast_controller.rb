# frozen_string_literal: true

module Api
  module V1
    class ForecastController < ApplicationController
      def index
        coordinates = MapQuestFacade.get_coordinates(params[:location])
        weather = OpenWeatherFacade.get_forecast(coordinates)
        binding.pry
        render json: ForecastSerializer.format_forecast(weather)
      end
    end
  end
end
