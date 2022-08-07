# frozen_string_literal: true

module Api
  module V1
    class ForecastController < ApplicationController
      def index
        location = MapQuestFacade.get_coordinates(params[:location])
        forecast = OpenWeatherFacade.get_forecast(location.lat, location.lng)
        json_hash = ForecastSerializer.format_forecast(forecast)
        render json: json_hash
      end
    end
  end
end
