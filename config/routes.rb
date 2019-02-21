Rails.application.routes.draw do
  devise_for :users
  get 'main/index'
  root 'main#index'

  resources :todos do
    member do
      patch 'done'
    end
  end
  
  resources :tags do
    member do
      get "tags/tag_form" => 'tags#new', :as => :new
    end
  end



end