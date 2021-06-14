# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json },controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
    
  }

  root 'movies#index'

  resources :cinema_halls, :movies, :ticket_desks, :clients

  resources :movies do
    resources :screenings do
      resources :reservations do
        resources :tickets, only: %i[index show]
      end
    end
  end


  # offline endpoint
  scope module: 'offline' do
    resources :ticket_desks, only: %i[index show] do
      resources :reservations
    end
  end

  # online endpoint
  scope module: 'online' do
    resources :clients do
      resources :reservations
    end
  end

  Montecinema::Application.routes.draw do
    mount Sidekiq::Web => '/sidekiq' # mount Sidekiq::Web in your Rails app
  end
end
