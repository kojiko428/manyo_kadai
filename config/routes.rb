Rails.application.routes.draw do
  root 'tasks#index'
  resources :users
  resources :tasks do
    collection do
      post :confirm
   end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
