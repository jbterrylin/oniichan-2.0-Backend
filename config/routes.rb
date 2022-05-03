Rails.application.routes.draw do
  # resources :login, :only => [:create]
  post '/login', to: 'login#create'

  resources :users
  resources :user_shop
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  match '*unmatched', to: 'application#route_not_found', via: :all

end
