Rails.application.routes.draw do
  devise_for :users
  root to: "duties#index"
  resources :duties, only: [:index, :new, :create, :show, :destroy]
end
