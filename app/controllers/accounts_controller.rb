class AccountsController < ApplicationController

  def email
    if session[:omniauth]
      if params[:email]
        # let's check if we already have a user with this email first
        user = User.where(email: params[:email]).first

        # if no existing users share this email, let's make one
        if user.blank?
          user = User.new
          user.email = params[:email]
          
          user.apply_omniauth(session[:omniauth])

          if user.save
            user.authentications.create!(provider: session[:omniauth]['provider'], uid: session[:omniauth]['uid'])
            session[:omniauth] = nil
            # Create a new User through omniauth
            # Register the new user + create new authentication
            flash[:notice] = t(:welcome, scope: [:authentications])
            sign_in_and_redirect(:user, user)
          
          else
            flash[:alert] = user.errors.to_a[0]
            redirect_to new_user_registration_url
          end

        # but if we do have a match, let's just add this as an authentication
        else
          user.authentications.create!(provider: session[:omniauth]['provider'], uid: session[:omniauth]['uid'])
          session[:omniauth] = nil
          flash[:notice] = t(:auth_success, scope: [:authentications])
          sign_in_and_redirect(:user, user)
        end
        
      end
    else
      flash[:alert] = t(:auth_fail)
      redirect_to new_user_registration_url
    end
  end
end
