# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    get 'profile', to: 'profile#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete '/logout', to: 'auth#logout'

    resources :bulletins, only: %i[index show new create edit update] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    namespace 'admin' do
      get '/', to: 'bulletins#index'
      resources :bulletins, only: [:index] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
      resources :categories, only: %i[index new create edit update destroy]
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
end
