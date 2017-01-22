Rails.application.routes.draw do


  get 'home' => 'static_pages#home', as: :home
  get 'about' => 'static_pages#about', as: :about

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :resourceries, only: [:new, :create, :destroy]
  resources :invitations, only: [:show]
  resources :users do
    resources :resources
    resources :philosophies, only: [:new, :create, :update, :edit]
    resources :certifications, only: [:new, :create, :update, :edit, :destroy]
  end
  resources :preps do
    collection do
      get :archived
    end
    resources :contests
    resources :photos
    resources :cardios
    resources :target_cardios
    resources :macros
    resources :target_macros
    resources :bodyweights
    resources :resources, only: [:show]
    resources :resourceries, only: [:index]
    resources :conversations, only: [:create] do
      resources :messages, only: [:new, :create, :index]
    end
  end


  root 'users#show'
  get 'preps/:prep_id/photos/poses/:tag' => 'photos#index', as: :pose
  get 'preps/:prep_id/self_coach' => 'preps#self_coach', as: :selfie
  get 'preps/:prep_id/coaches' => 'users#index', as: :coaches
  get 'preps/:prep_id/coach/:id' => 'users#show', as: :coach
  get 'preps/:prep_id/athlete/:id' => 'users#show', as: :athlete
  get 'preps/:prep_id/coach_request/:id' => 'invitations#new', as: :new_coach_request
  post 'preps/:prep_id/coach_request/:id' => 'invitations#create', as: :coach_request
  get 'preps/:prep_id/invite/:id' => 'invitations#show', as: :invite_view
  post 'preps/:prep_id/invite/:id' => 'invitations#accept_invite', as: :accept_invite
  delete 'preps/:prep_id/invite/:id' => 'invitations#destroy', as: :deny_invite
end
