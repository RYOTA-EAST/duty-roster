Rails.application.routes.draw do
  devise_for :users
  root to: "dutys#index"
  resources :dutys, only: :index
end
