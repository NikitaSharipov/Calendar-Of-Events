Rails.application.routes.draw do
  devise_for :users

  resources :events, only: %i[index], shallow: true do
    get :all, on: :collection
  end
  resources :users, only: %i[show update]

  root to: "events#index"
end
