Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: "duties#index"
  resources :duties do
    resources :rosters, only: [:new, :create, :destroy]
  end
end
