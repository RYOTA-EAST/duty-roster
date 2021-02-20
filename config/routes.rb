Rails.application.routes.draw do
  devise_for :users
  root to: "duties#index"
  resources :duties do
    resources :rosters, only: [:new, :create, :destroy]
  end
end
