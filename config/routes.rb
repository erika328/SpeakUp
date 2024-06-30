Rails.application.routes.draw do
  root "tops#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks",
    passwords: 'users/passwords'
  }

  resources :rankings, only: [:index]
  resources :pronunciation_scores, only: [:create, :index, :show]
  resources :pronunciation_texts, only: [:index]
  resources :words do
    collection do
      get 'random'
    end
    member do
      patch 'update_review_status'
    end
  end

  resources :videos, only: [:index, :show] do
    resources :likes, only: [:create, :destroy]
  end
end
