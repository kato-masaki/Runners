Rails.application.routes.draw do
  devise_for :users

  root 'homes#top'

  resources :diaries do
    resource :favorites, only: [:create, :destroy]
    resources :diary_comments, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end

  get 'weekly_rank' => 'diaries#weekly_rank', as: 'weekly_rank'

  get 'bookmarks' => 'bookmarks#index', as: 'bookmarks'

  resources :users, only: [:show, :edit, :update, :destroy] do
    member do
      get :unsubscribe
    end
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :records, only: [:create, :index, :edit, :update, :destroy]

  get '/search' => 'search#search'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
end
