Roomies::Application.routes.draw do

  root :to => 'pages#home'

  resource :corkboard, only: %w(show)
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
      post :undo_complete
    end
  end
  resources :categories
  resources :achievements
  resources :houses
  resources :user_mailer
  resources :house_invitations
  resources :rewards

  match '/auth/:provider/callback'      => 'authentications#create'
  match '/auth/failure'                 => 'authentications#failure'
  match '/auth/facebook/setup'          => 'facebook#setup'
  match '/registrations'                => 'accounts#email'
  match '/user/:id/homeless/:house_id'  => 'houses#destroy_roomie', :as => :homeless
  match '/support/index'                => 'support#submit_request'
  match '/assignments/day/:day'         => 'assignments#day'
  match '/beta_sign_up/:invite_token'   => 'users#new', :as => :beta_sign_up
  match '/confirmations'                => 'assignments#confirmations'
  match '/past_due_assignments'         => 'assignments#past_due_assignments'
  match '/assignments/:id/confirm'      => 'assignments#confirm'
  match '/assignments/:id/reject'       => 'assignments#reject'
  match '/house_invitations/:id/accept' => 'users#accept_house_invitation'
  match '/house_invitations/:id/reject' => 'users#reject_house_invitation'
  match '/payment/callback/'            => 'payments#handle', :via => :post
  match '/about'                        => 'pages#about'
  match '/privacy'                      => 'pages#privacy'
  match '/service'                      => 'pages#service'
  match '/rewards/view_all'             => 'rewards#past_rewardarize'

end
