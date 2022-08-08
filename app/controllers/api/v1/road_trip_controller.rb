# frozen_string_literal: true

module Api
  module V1
    class RoadTripController < ApplicationController
      def create
        if !auth_and_verify
          directions = MapQuestFacade.get_directions(params[:origin], params[:destination])
          location = MapQuestFacade.get_coordinates(params[:destination])
          arrival_forecast = OpenWeatherFacade.get_forecast(location.lat, location.lng)
          json_hash = RoadTripSerializer.format_roadtrip(
            params[:origin],
            params[:destination],
            directions,
            arrival_forecast
          )
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
