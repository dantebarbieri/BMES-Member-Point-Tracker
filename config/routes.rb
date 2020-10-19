# frozen_string_literal: true

Rails.application.routes.draw do
  get 'accomplishments_members/index'
  get 'accomplishments_members/show'
  get 'accomplishments_members/new'
  get 'accomplishments_members/edit'
  get 'accomplishments_members/delete'
  get 'upcoming_events' => 'upcoming_events#show'
  get 'upcoming_events/show'
  get 'memberevents/index'
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

  post 'manual_points/create_semester_transfer' => 'manual_points#create_semester_transfer'
  get 'manual_points/semester_transfer' => 'manual_points#semester_transfer'

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

  resources :accomplishments_members do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'auth/auth0/callback' => 'auth0#callback'

  get 'auth/failure' => 'auth0#failure'

  get 'logout' => 'logout#logout'

  get 'dashboard' => 'dashboard#show'

  get 'signup' => 'signup#new'

  post 'signup' => 'signup#create'

  get 'profile' => 'profile#show'

  get 'edit' => 'profile#edit'

  patch 'edit' => 'profile#update'

  get 'points' => 'points#index'
  
  get 'points/events'
  get 'points/manual_points'
  get 'points/accomplishments'

  get 'members' => 'member_management#index'

  get 'members/:id' => 'member_management#show'
  patch 'members/confirm/:id' => 'member_management#confirm'
  delete 'members/delete/:id' => 'member_management#delete'

  get 'admins' => 'admin_management#index'
  
  get 'admins/:id' => 'admin_management#show'
  patch 'admins/grant/:id' => 'admin_management#grant'
  patch 'admins/revoke/:id' => 'admin_management#revoke'
end
