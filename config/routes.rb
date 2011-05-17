Roomies::Application.routes.draw do

  root :to => 'home#index'

  devise_for :users
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy"
  end

  resources :users
  resources :pages
  resources :support
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
  resources :user_mailer
  resources :house_invitations
  resources :rewards

  match '/auth/:provider/callback'      => 'authentications#create'
  match '/auth/failure'                 => 'authentications#failure'
  match '/auth/facebook/setup'          => 'facebook#setup'
  match '/registrations'                => 'accounts#email'
  match '/user/:id/homeless/:house_id'  => 'houses#destroy_roomie', :as => :homeless
  match '/support/index'                => 'support#submit_request'
  match '/accept_house_invitation'      => 'users#accept_house_invitation'
  match '/reject_house_invitations'     => 'users#reject_house_invitations'
  match '/assignments/day/:day'         => 'assignments#day'
  match '/past_due'                     => 'assignments#past_due'
  match '/confirmations'                => 'assignments#confirmations'
  match '/assignments/:id/confirm'      => 'assignments#confirm'
  match '/assignments/:id/reject'       => 'assignments#reject'

end
