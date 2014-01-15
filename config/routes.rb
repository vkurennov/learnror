Learnror::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  namespace :admin do
    resources :products
    resources :categories
  end

  root to: 'site#index'
end
