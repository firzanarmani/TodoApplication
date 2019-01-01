Rails.application.routes.draw do
  get 'main/index'
  root 'main#index'

  resources :todos
end
