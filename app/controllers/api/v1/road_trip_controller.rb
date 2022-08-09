# frozen_string_literal: true

module Api
  module V1
    class RoadTripController < ApplicationController
      def create
        if !auth_and_verify
          origin = params[:origin]
          destination = params[:destination]
          route = MapQuestFacade.get_directions(origin, destination)
          if route.travel_time == 'impossible route'
            json_hash = RoadTripSerializer.format_impossible_route(origin, destination)
            # render json: json_hash
          else
            # binding.pry
            # location = MapQuestFacade.get_coordinates(params[:destination])
            arrival_forecast = OpenWeatherFacade.get_forecast(route.destination_lat, route.destination_lng)
            json_hash = RoadTripSerializer.format_roadtrip(
              origin,
              destination,
              route,
              arrival_forecast
            )
          end
          render json: json_hash
        else
          error_handler(auth_and_verify[:message], auth_and_verify[:status])
        end
      end

      private

      def api_key
        api_key ||= ApiKey.find_by(token: params[:api_key])
      end

      def auth_and_verify
        origin = params[:origin]
        destination = params[:destination]
        if !api_key
          error_message = { api_key: ['is invalid'] }
          { message: error_message, status: :unauthorized }
        elsif origin.blank? || destination.blank?
          error_message = { required_information: ['is missing'] }
          { message: error_message, status: :bad_request }
        end
      end
    end
  end
end
