Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resource :profile, only: [:edit, :update], controller: 'profiles'
  root to: "pages#home"
  get "/plans", to: "pages#plans", as: :plans
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :companies
  resources :clients
  resources :invoices do
    resources :detail_invoices, only: [:new, :create, :edit, :update, :destroy]
    member do
      post :send_pdf_to_user
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
