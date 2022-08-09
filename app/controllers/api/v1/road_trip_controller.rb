# frozen_string_literal: true

module Api
  module V1
    class RoadTripController < ApplicationController
      def create
        if !auth_and_verify
          route = MapQuestFacade.get_directions(origin, destination)
          if route.travel_time == 'impossible route'
            json_hash = RoadTripSerializer.format_impossible_route(origin, destination)
          else
            arrival_forecast = OpenWeatherFacade.get_forecast(route.destination_lat, route.destination_lng)
            json_hash = RoadTripSerializer.format_roadtrip(origin, destination, route, arrival_forecast)
          end
          render json: json_hash
        else
          error_handler(auth_and_verify[:message], auth_and_verify[:status])
        end
      end

      private

      def api_key
        @api_key ||= ApiKey.find_by(token: params[:api_key])
      end

      def origin
        @origin ||= params[:origin]
      end

      def destination
        @destination ||= params[:destination]
      end

      def auth_and_verify
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
