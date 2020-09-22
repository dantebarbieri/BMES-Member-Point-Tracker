Rails.application.routes.draw do
  resources :manual_points do
    member do
      get :edit
    end
  end

  resource :accomplishmnets do
  	member do
  		get :edit
  	end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
