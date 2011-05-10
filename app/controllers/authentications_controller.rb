class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
    @u = current_user ||= "none"
  end

  def create

    omniauth = request.env['omniauth.auth']
    authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
  
    if authentication
      # Just sign in an existing user with omniauth
      # The user have already used this external account
      flash[:notice] = t('.signed_in')
      sign_in_and_redirect(:user, authentication.user)

    elsif current_user
      # Add authentication to signed in user
      # User is logged in      
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = t(:auth_success)
      redirect_to authentications_url
    
    elsif omniauth['provider'] != "twitter"
      user = create_new_omniauth_user(omniauth)
      if not user.new_record?
        flash[:notice] = "#{omniauth['provider'].titleize} " + t('.new_login_provider')
      else
        flash[:notice] = t('.welcome_back')
      end
      user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      # Create a new User through omniauth
      # Register the new user + create new authentication
      sign_in_and_redirect(:user, user)
    
    elsif omniauth['provider'] == "twitter"
      omniauth['uid'] && (omniauth['user_info']['name'] || omniauth['user_info']['nickname'] || 
      (omniauth['user_info']['first_name'] && omniauth['user_info']['last_name']))
      session[:omniauth] = omniauth.except('extra');
      redirect_to(:controller => 'accounts', :action => 'email')
      
    else
      render :text, user.errors
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = t('.auth_destroy')
    redirect_to authentications_url
  end

  def create_new_omniauwth_user(omniauth)
    user = User.where(:email => omniauth['user_info']['email']).first
    unless user
      user = User.new
      user.apply_omniauth(omniauth)
    end
    user
  end

  def failure
    flash[:error] = t('.oauth_error')
    redirect_to root_path
  end
end
