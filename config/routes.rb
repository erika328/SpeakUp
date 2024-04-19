Rails.application.routes.draw do
  resources :words
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  root "tops#index"
end
