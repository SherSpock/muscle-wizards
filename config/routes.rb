Rails.application.routes.draw do

  devise_for :users
  resources :preps do
    resources :contests
    resources :photos
    resources :cardios
    resources :macros
    resources :bodyweights
  end

  root 'preps#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
