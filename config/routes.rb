Rails.application.routes.draw do


  devise_for :users

  root 'homes#top'

  resources :diaries do
    resource :favorites, only: [:create, :destroy]
    resources :diary_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    resource :relationships,only: [:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :records, only: [:create, :index, :edit, :update, :destroy]

  get '/search' => 'search#search'
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

end
