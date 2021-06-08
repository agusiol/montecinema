# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'movies#index'

  resources :cinema_halls, :movies, :ticket_desks, :clients

 
  resources :movies do
    resources :screenings
  end

  resources :reservations do
    resources :tickets, only: %i[index show]
  end

  resources :ticket_desks, only: %i[index show] do
    resources :movies, only: %i[index show] do
      resources :screenings, only: %i[index show] do
        resources :reservations do
          resources :tickets, only: %i[index show]
        end
      end
    end
  end

  Montecinema::Application.routes.draw do
    mount Sidekiq::Web => '/sidekiq' # mount Sidekiq::Web in your Rails app
  end
end
