Rails.application.routes.draw do

  resources :events do
    member do
      get :delete
      get :postpone
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
