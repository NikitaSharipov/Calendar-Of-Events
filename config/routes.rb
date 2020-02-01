Rails.application.routes.draw do
  devise_for :users

  resources :events, only: %i[index]
  resources :users, only: %i[show update]

  root to: "events#index"
end
