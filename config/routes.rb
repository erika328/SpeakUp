Rails.application.routes.draw do
  resources :pronunciation_scores, only: [:create]
  get 'pronunciation_texts/show'
  get 'videos/index'
  get 'videos/show'
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  resources :words
  root "tops#index"
  resources :videos, only: [:index, :show]
end