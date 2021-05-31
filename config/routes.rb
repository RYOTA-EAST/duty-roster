Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: "duties#index"
  resources :duties do
    collection do
      get 'mypage'
      get 'search'
    end
    resources :rosters, only: [:new, :create, :destroy]
  end
end
