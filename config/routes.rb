Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "cinema_halls#index"

  resources :movies
  
  resources :cinema_halls, :path => '/cinema-halls' do
    resources :movies do
      resources :screenings
    end
  end

  resources :screenings do
    resources :reservations do
      resources :tickets
    end
  end

end
