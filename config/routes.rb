Rails.application.routes.draw do
  get "home/index"
  devise_for :users
  root to: "home#index"

  #Add only: restrictions later

  namespace :trader do
    get "transactions/index"
    get "transactions/show"
    get "transactions/new"
    get "stocks/index"
    get "stocks/show"
    resources :stocks
    resources :transactions
    root to: "dashboard#index"
  end

  namespace :admin do
    get "dashboard/index"
    get "transactions/index"
    get "transactions/show"
    get "traders/index"
    get "traders/show"
    get "traders/edit"
    get "traders/new"
    resources :trader
    resources :transactions
    root to: "dashboard#index"
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
