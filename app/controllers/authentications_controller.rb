class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
  
    if authentication
      # Just sign in an existing user with omniauth
      # The user have already used this external account
      flash[:notice] = t(:signed_in, scope: [:authentications])
      sign_in_and_redirect(:user, authentication.user)

    elsif current_user
      # Add authentication to signed in user
      # User is logged in      
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = t(:auth_success, scope: [:authentications])
      redirect_to authentications_url

    elsif omniauth['provider'] != 'twitter' && omniauth['provider'] != 'linked_in' && user = create_new_omniauth_user(omniauth)
      user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      # Create a new User through omniauth
      # Register the new user + create new authentication
      flash[:notice] = t(:welcome, scope: [:authentications])
      sign_in_and_redirect(:user, user)

    elsif (omniauth['provider'] == 'twitter' || omniauth['provider'] == 'linked_in') && 
      omniauth['uid'] && (omniauth['user_info']['name'] || omniauth['user_info']['nickname'] || 
      (omniauth['user_info']['first_name'] && omniauth['user_info']['last_name']))
      session[:omniauth] = omniauth.except('extra');
      flash[:notice] = t(:missing_email, scope: [:authentications])
      redirect_to(:controller => 'accounts', :action => 'email')
    else
      debugger; 'blah'
      # New user data not valid, try again
      flash[:alert] = t(:auth_fail, scope: [:authentications])
      redirect_to new_user_registration_url
    end
    
  end

  # Destroy an authentication
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = t(:auth_destroy, scope: [:authentications])
    redirect_to authentications_url
  end

  def create_new_omniauth_user(omniauth)
    if not omniauth['user_info']['email'].blank?
      user = User.where(email: omniauth['user_info']['email']).first
    end

    if user.blank?
      user = User.new
    end

    user.apply_omniauth(omniauth)

    if user.save
      user
    else
      nil
    end
  end

  def failure
    flash[:error] = t(:auth_error, scope: [:authentications])
    redirect_to root_path
  end
end
