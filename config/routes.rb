# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  apipie
  devise_for :users, defaults: { format: :json }, controllers: {
    sessions: 'users/sessions'

  }

  root 'movies#index'

  resources :cinema_halls, :movies, :ticket_desks, :screenings

  resources :movies do
    resources :screenings do
      resources :reservations
    end
  end

  # offline endpoint
  namespace :offline do
    resources :reservations
  end

  # online endpoint
  namespace :online do
    resources :reservations
  end

  Montecinema::Application.routes.draw do
    mount Sidekiq::Web => '/sidekiq' # mount Sidekiq::Web in your Rails app
  end
end
