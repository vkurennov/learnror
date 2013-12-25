Learnror::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  namespace :admin do
    resources :products
  end

  root to: 'site#index'
end
