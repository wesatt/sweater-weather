# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        if user.save
          api_key = user.api_keys.create!(token: SecureRandom.hex)
          response_hash = UserSerializer.format_user(user, api_key)
          render json: response_hash, status: :created
        else
          error_message = user.errors.messages
          error_handler(error_message, :bad_request)
        end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end
