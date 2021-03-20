Rails.application.routes.draw do
  # 別のユーザーページを打つとタスク一覧に画面に飛ぶ設定
  root 'tasks#index'
  resources :users
  resources :tasks do
    collection do
      post :confirm
   end
  end

  resources :sessions, only: [:new, :create, :destroy]
  # resources :favorites, only: [:create, :destroy]

  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    end
  end
end
