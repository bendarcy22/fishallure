Rails.application.routes.draw do
  devise_for :users
  root 'homepage#index'
  resources :homepage, only: [:index]

  namespace :api do
    resources :catches, only: [:index, :show]
  end

  resources :catches

  resources :lures do
    collection do
      get 'hot'
    end
  end

  resources :fish_types do
    collection do
      get 'hot'
    end
  end
end
