Roomies::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy"
  end

  scope "(:locale)", :locale => /en|fr/ do

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
  
  end

  match '/auth/:provider/callback'     => 'authentications#create'
  match '/registrations'               => 'registrations#email'
  match '/user/:id/homeless/:house_id' => 'houses#destroy_roomie', :as => :homeless
  match '/support/index'               => 'support#submit_request'
  match '/accept_invitation'           => 'users#accept_invitation'
  match '/reject_invitations'          => 'users#reject_invitations'
  # match '/assignments/:id/complete'    => 'assignments#complete'

  # making sure the root works with I18N
  match '/:locale' => 'home#index'
  # normal visitors are directed to the home page
  root :to => 'home#index'

end
