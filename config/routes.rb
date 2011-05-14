Roomies::Application.routes.draw do

  root :to => 'home#index'

  devise_for :users
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy"
  end

  resources :users
  resources :authentications
  resources :assignments do
    member do
      post :complete
    end
  end
  resources :categories
  resources :achievements
  resources :houses
  resources :corkboard
  resources :pages
  resources :support
  resources :user_mailer
  resources :invitations
  resources :rewards
  resources :beta_invites

  match '/auth/:provider/callback'      => 'authentications#create'
  match '/auth/failure'                 => 'authentications#failure'
  match '/registrations'                => 'accounts#email'
  match '/user/:id/homeless/:house_id'  => 'houses#destroy_roomie', :as => :homeless
  match '/support/index'                => 'support#submit_request'
  match '/accept_invitation'            => 'users#accept_invitation'
  match '/reject_invitations'           => 'users#reject_invitations'
  match '/assignments/day/:day'         => 'assignments#day'
  match '/past_due'                     => 'assignments#past_due'
  match '/beta_sign_up/:invite_token'   => 'users#new', :as => :beta_sign_up
  match '/confirmations'                => 'assignments#confirmations'
  match '/assignments/:id/confirm'      => 'assignments#confirm'
  match '/assignments/:id/reject'       => 'assignments#reject'

  match '/:locale' => 'home#index'

end
