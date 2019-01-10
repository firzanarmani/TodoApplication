Rails.application.routes.draw do
  get 'main/index'
  root 'main#index'

  resources :todos
  resources :tags
  #get 'tags/:tag' , to: 'todos#index', as: :tag
end
