require 'sidekiq/web'

Learnror::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :admin do
    resources :products
    resources :categories
    resources :users, only: [:index, :show] do
      resources :permissions, only: [:index, :create, :destroy]
    end
  end
  resources :lots, only: [:index, :show] do
    resources :bets, only: [:create]
  end

  resource :profile

  root to: 'site#index'
end
