Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  #Add only: restrictions later

  namespace :trader do
    resources :stocks do
      collection do
        get :search
      end
    end
    resources :transactions
    root to: "dashboard#index"
  end

  namespace :admin do
    resources :traders do
      get :pending, on: :collection
      patch :approve, on: :member
    end
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
