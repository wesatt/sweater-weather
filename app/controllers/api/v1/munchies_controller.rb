# frozen_string_literal: true

module Api
  module V1
    class MunchiesController < ApplicationController
      def index
        location = params[:location]
        food = params[:food]
        coordinates = MapQuestFacade.get_coordinates(location)
        forecast = OpenWeatherFacade.get_forecast(coordinates.lat, coordinates.lng).current_formatted
        restaurant = YelpFacade.get_restaurant(location, food)
        json_hash = MunchieSerializer.format_munchies(location, forecast, restaurant)
        binding.pry
        render json: json_hash
      end
    end
  end
end
