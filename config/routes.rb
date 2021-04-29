Rails.application.routes.draw do
  
  get 'items/index'
  get 'items/show'
  root to: "homes#top"
  get 'homes/about'
  # customers table
  resources :customers, only: [:show, :edit, :update, :destroy]
  get "customers/confirm" => "customers#confirm"
  
  
  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions'
  }
  devise_for :customers, :controllers => {
        :sessions => 'customers/sessions',
        :registrations => 'customers/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
