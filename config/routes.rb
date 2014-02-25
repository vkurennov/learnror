Learnror::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  namespace :admin do
    resources :products
    resources :categories
  end
  resources :lots, only: [:index, :show] do
    resources :bets, only: [:create]
  end

  resource :profile

  root to: 'site#index'
end
