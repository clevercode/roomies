Roomies::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy"
  end

  resources :users
  resources :authentications
  resources :assignments
  resources :categories
  resources :achievements
  resources :houses
  resources :corkboard
  resources :pages
  resources :support
  resources :user_mailer
  resources :invitations

  match '/auth/:provider/callback'     => 'authentications#create'
  match '/registrations'               => 'registrations#email'
  match '/user/:id/homeless/:house_id' => 'houses#destroy_roomie', :as => :homeless
  match '/support/index'               => 'support#submit_request'
  match '/accept_invitation'           => 'users#accept_invitation'
  match '/reject_invitations'          => 'users#reject_invitations'

  # normal visitors are directed to the home page
  root :to => 'home#index'

  # ensures the root for logged in users is the corkboard
  namespace :user do
    root :to => 'corkboard#index'
  end

end
