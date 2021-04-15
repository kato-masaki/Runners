Rails.application.routes.draw do

  # get 'users/show'
  # get 'users/edit'
  devise_for :users
  root 'homes#top'
  resources :diaries do
    resource :favorites, only: [:create, :destroy]
    resources :diary_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :update]

end
