Rails.application.routes.draw do
  resources :rankings, only: [:index]
  resources :pronunciation_scores, only: [:create, :index, :show]
  resources :pronunciation_texts, only: [:index]
  get 'videos/index'
  get 'videos/show'
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        omniauth_callbacks: "users/omniauth_callbacks",
        passwords: 'users/passwords'
      }
  resources :words do
    collection do
      get 'random'
    end
    member do
      patch 'update_review_status'
    end
  end

  root "tops#index"
  resources :videos, only: [:index, :show] do
    resource :like, only: [:create, :destroy]
  end
end