Rails.application.routes.draw do
  resources :flats
  root to: 'flats#index'

  # GET /api/v1/flats (unauthenticated)
  namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :addresses, only: [ :index ]
      end
    end

  #  GET /api/v1/restaurants/:id (unauthenticated)
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :addresses, only: [ :index, :show ]
    end
  end



end
