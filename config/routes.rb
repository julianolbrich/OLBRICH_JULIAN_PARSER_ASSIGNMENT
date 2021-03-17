Rails.application.routes.draw do
  resources :flats
  root to: 'flats#index'

  #  GET /api/v1/flats (unauthenticated)
  #  GET /api/v1/restaurants/:id (unauthenticated)
  #  POST /api/v1/restaurants
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :addresses, only: [ :index, :show, :create ]
    end
  end

end
