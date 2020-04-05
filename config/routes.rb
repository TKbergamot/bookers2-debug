# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show index edit update search] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i[create destroy]
  resources :books do
    resource :favorites, only: %i[create destroy]
    resources :book_comments, only: %i[create destroy]
  end
  root 'home#top'
  get 'home/about'
  get 'search' => 'search#show'
end
