Rails.application.routes.draw do
  
  root 'home#show'
  
  get 'home/show'
 
  resources :events do
    member do
      get :delete
      get :postpone
    end
  end

  resources :semesters do
    member do
      get :delete
    end
  end
  
  resources :manual_points do
    member do
      get :delete
    end
  end

  resources :accomplishments do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'auth/auth0/callback' => 'auth0#callback'

  get 'auth/failure' => 'auth0#failure'

  get 'logout' => 'logout#logout'

  get 'dashboard' => 'dashboard#show'

  get 'semesters' => 'semesters#index'

  get 'signup' => 'signup#new'
  
  post 'signup' => 'signup#create'

  get 'profile' => 'profile#show'

  get 'edit' => 'profile#edit'

  patch 'edit' => 'profile#update'
end
