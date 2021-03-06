Roomies::Application.routes.draw do

  root :to => 'pages#home'

  if Rails.env.development?
    match '/patterns' => 'argyle/patterns#index'
  end

  match '/me' => 'users#show', as: 'current_user'
  match '/house' => 'houses#show', as: 'current_house'
  resource :corkboard, only: %w(show)
  resource :support_request, only: %w(new create)

  match '/auth/:provider/callback'      => 'authentications#create'
  match '/auth/failure'                 => 'authentications#failure'

  devise_for :users do
    get '/sign_in', to: 'devise/sessions#new'
    get '/sign_out', to: 'devise/sessions#destroy'
  end


  resources :users
  resources :pages
  resources :assignments do
    member do
      post :complete
      post :undo_complete
    end
  end
  resources :categories
  resources :achievements

  resource  :house do
    resource :subscription
  end

  resources :houses 

  resources :user_mailer
  resources :house_invitations
  resources :rewards

  match '/registrations'                => 'accounts#email'
  match '/user/:id/homeless/:house_id'  => 'houses#destroy_roomie', :as => :homeless
  match '/assignments/day/:day'         => 'assignments#day'
  match '/confirmations'                => 'assignments#confirmations', as: 'confirmations'
  match '/past_due_assignments'         => 'assignments#past_due_assignments', as: 'past_due_assignments'
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
