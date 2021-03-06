Rails.application.routes.draw do
  devise_for :users
  root 'homepage#index'
  resources :homepage, only: [:index]

  namespace :api do
    resources :catches, only: [:index] do
      collection do
        get 'personal'
      end
    end
    resources :fish_types, only: [:show]
  end

  resources :catches do
    collection do
      get 'recent'
    end
    collection do
      get 'personal'
    end
  end

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
