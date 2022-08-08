# frozen_string_literal: true

module Api
  module V1
    class MunchiesController < ApplicationController
      def index
        location = params[:location]
        food = params[:food]
        coordinates = MapQuestFacade.get_coordinates(location)
        forecast = OpenWeatherFacade.get_forecast(coordinates.lat, coordinates.lng)
        restaurants = YelpFacade.get_restaurants(location, food)
        json_hash = MunchieSerializer.format_munchie(location, forecast.current_formatted, restaurants.first)
        render json: json_hash
      end
    end
  end
end
