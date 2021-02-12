Rails.application.routes.draw do
  resources :dutys, only: :index
end
