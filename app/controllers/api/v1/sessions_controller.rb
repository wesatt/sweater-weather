# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params[:email])
        if !user.nil? && user.authenticate(params[:password])
          api_key = user.api_keys.first
          response_hash = UserSerializer.format_user(user, api_key)
          render json: response_hash
        else
          error_message = { provided_credentials: ['are invalid'] }
          error_handler(error_message, :unauthorized)
        end
      end
    end
  end
end
