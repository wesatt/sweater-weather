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
          render json: auth_and_verify[:response], status: auth_and_verify[:status]
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
          error_messages = { api_key: ['is invalid'] }
          response_hash = ErrorSerializer.format_error(error_messages)
          { response: response_hash, status: :unauthorized }
        elsif origin.blank? || destination.blank?
          error_messages = { required_information: ['is missing'] }
          response_hash = ErrorSerializer.format_error(error_messages)
          { response: response_hash, status: :bad_request }
        end
      end
    end
  end
end
