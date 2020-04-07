# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: %i[show index edit update search] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i[create destroy]
  resources :books do
    resource :favorites, only: %i[create destroy]
    resources :book_comments, as: 'comments', only: %i[create destroy]
  end
  resources :chats, only: [:create]
  resources :rooms, only: %i[create show index]
  root 'home#top'
  get 'home/about'
  get 'search' => 'search#show'
end
