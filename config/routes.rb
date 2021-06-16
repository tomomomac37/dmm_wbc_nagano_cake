Rails.application.routes.draw do
  
  namespace :admins do
  end
  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions'
  }
  devise_for :customers, :controllers => {
        :sessions => 'customers/sessions',
        :registrations => 'customers/registrations'
  }
  
  scope module: :customers do
    root "homes#top"
    get "homes/about" => "homes#about"
    # 商品
    resources :items, only: [:show, :index]
    get 'genres/:id/genre_items' => 'items#genre_items'
    # 注文
    get "orders/confirm_order" => "orders#confirm_order"
    get "orders/thanks" => "orders#thanks"
    resources :orders, only: [:new, :show, :create, :index]
    # 会員
    get "confirm" => "customers#confirm"
    patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
    resources :customers, only: [:show, :edit, :update]
    # カート
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:create, :index, :update, :destroy]
    # 登録先住所
    resources :addresses, only: [:new, :create, :edit, :update, :destroy]
  end
  
  namespace :admins do
    # 商品
    resources :items, only: [:new, :show, :create, :edit, :index, :update]
    # 注文
    get "/admin" => "homes#top"
    patch "orders/sales_order_status" => "orders#sales_order_status_update"
    patch "orders/production_status" => "orders#production_status_update"
    resources :orders, only: [:show, :index]
    # ジャンル
    resources :genres, only: [:create, :index, :update, :edit]
    # カート
    resources :cart_items, only: [:update]
    # 会員
    resources :customers, only: [:show, :index, :edit, :update, :destroy]
    # 検索
    get 'search' => 'searches#search'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
