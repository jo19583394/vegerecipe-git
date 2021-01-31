Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  resources :users do
    member do
      get 'followings'
      get 'followers'
      get 'favorites'
    end
    resources :favorites, only: [:create, :destroy]
  end
  
  resources :recipes do
    collection do
      get 'search'
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
end
