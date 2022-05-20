Rails.application.routes.draw do
  # resources :login, :only => [:create]
  post '/login', to: 'login#create'

  resources :users
  resources :user_shops
  resources :items
  resources :customers
  resources :papers

  post '/papers_with_pagination', to: 'papers#pagination'
  post '/items_with_pagination', to: 'items#pagination'
  post '/customers_with_pagination', to: 'customers#pagination'
  put '/like_customer', to: 'customers#like'


  resources :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  match '*unmatched', to: 'application#route_not_found', via: :all

end
