Rails.application.routes.draw do
  defaults format: :json do
    mount_devise_token_auth_for 'User', at: 'auth'

    resources :doctors, only: [:index, :show] do
      member do
        get :schedules, to: "schedules#index"
        get '/schedules/:schedule_id', to: "schedules#show", as: :schedule
      end
    end
    resources :hospitals, only: [:index, :show]
    resources :bookings, only: [:index, :create, :show]
  end
end
