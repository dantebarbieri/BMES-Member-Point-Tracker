Rails.application.routes.draw do

  get 'dashboard/show'
  root 'home#show'
  
  get 'home/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'auth/auth0/callback' => 'auth0#callback'

  get 'auth/failure' => 'auth0#failure'

  get '/logout' => 'logout#logout'

  get 'dashboard' => 'dashboard#show'
end
