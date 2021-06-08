require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'cinema_halls#index'

  resources :movies

  resources :clients

  resources :cinema_halls, path: '/cinema-halls' do
    resources :movies do
      resources :screenings
    end
  end

  resources :ticket_desks do
    resources :screenings do
      resources :reservations do
        resources :tickets
      end
    end
  end

  Montecinema::Application.routes.draw do
    mount Sidekiq::Web => '/sidekiq' # mount Sidekiq::Web in your Rails app
  end
end
