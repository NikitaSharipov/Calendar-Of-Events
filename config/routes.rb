Rails.application.routes.draw do
  devise_for :users

  resources :events, only: %i[index]

  root to: "events#index"
end
