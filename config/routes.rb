# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :forecast, only: %i[index]
      resources :sessions, only: %i[create]
      resources :users, only: %i[create]
    end
  end
end
