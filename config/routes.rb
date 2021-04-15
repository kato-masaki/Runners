Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'
  resources :diaries do
    resource :favorites, only: [:create, :destroy]
    resources :diary_comments, only: [:create, :destroy]
  end

end
