Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resource :profile, only: [:edit, :update], controller: 'profiles'
  root to: "pages#home"
  get "/plans", to: "pages#plans", as: :plans


  get "up" => "rails/health#show", as: :rails_health_check

  resources :companies
  resources :clients
  resources :invoices do
    resources :detail_invoices, only: [:new, :create, :edit, :update, :destroy]
    member do
      post :send_pdf_to_user
    end
  end

  post '/elegir_pro', to: 'compras#elegir_pro', as: :elegir_pro
  post '/elegir_premium', to: 'compras#elegir_premium', as: :elegir_premium
  get '/compra_exitosa', to: 'compras#compra_exitosa', as: :compra_exitosa


  # Defines the root path route ("/")
  # root "posts#index"
end
