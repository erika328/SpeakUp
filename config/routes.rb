Rails.application.routes.draw do
  resources :pronunciation_scores, only: [:create]
  resources :pronunciation_texts, only: [:show]
  get 'videos/index'
  get 'videos/show'
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        omniauth_callbacks: "users/omniauth_callbacks"
      }
  resources :words
  root "tops#index"
  resources :videos, only: [:index, :show]
end