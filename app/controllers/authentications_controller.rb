class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
    @u = current_user ||= "none"
  end

  def create

    # create a new hash
    @authhash = Hash.new

    omniauth = request.env['omniauth.auth']
    authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
  
    if authentication
      # Just sign in an existing user with omniauth
      # The user have already used this external account
      flash[:notice] = t(:signed_in)
      sign_in_and_redirect(:user, authentication.user)

    elsif current_user
      # Add authentication to signed in user
      # User is logged in      
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = t(:auth_success)
      redirect_to authentications_url
    
    elsif omniauth['provider'] != 'twitter' && omniauth['provider'] != 'linked_in' && user = create_new_omniauth_user(omniauth)
      user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      # Create a new User through omniauth
      # Register the new user + create new authentication
      flash[:notice] = t(:welcome)
      sign_in_and_redirect(:user, user)
   
    elsif (omniauth['provider'] == 'twitter' || omniauth['provider'] == 'linked_in') && 
      omniauth['uid'] && (omniauth['user_info']['name'] || omniauth['user_info']['nickname'] || 
      (omniauth['user_info']['first_name'] && omniauth['user_info']['last_name']))
      session[:omniauth] = omniauth.except('extra');

      omniauth['user_info']['email'] ? @authhash[:email] =  omniauth['user_info']['email'] : @authhash[:email] = ''
      omniauth['user_info']['name'] ? @authhash[:name] =  omniauth['user_info']['name'] : @authhash[:name] = ''
      omniauth['uid'] ? @authhash[:uid] = omniauth['uid'].to_s : @authhash[:uid] = ''
      omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
      

      render :text => @authhash.to_yaml
      return
      redirect_to(:controller => 'accounts', :action => 'email')

    elsif (omniauth['provider'] == 'facebook')

      # debug to output the hash that has been returned when adding new services
      omniauth['extra']['user_hash']['email'] ? @authhash[:email] =  omniauth['extra']['user_hash']['email'] : @authhash[:email] = ''
      omniauth['extra']['user_hash']['name'] ? @authhash[:name] =  omniauth['extra']['user_hash']['name'] : @authhash[:name] = ''
      omniauth['extra']['user_hash']['id'] ?  @authhash[:uid] =  omniauth['extra']['user_hash']['id'].to_s : @authhash[:uid] = ''
      omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''

      render :text => @authhash.to_yaml
      return
      
      # user = create_new_omniauth_user(omniauth)
      # user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      
      # flash[:notice] = "Caught that Facebook fucker"
      # # redirect_to root_url
      # sign_in_and_redirect(:user, user)

    else
      # New user data not valid, try again
      flash[:alert] = t(:auth_fail)
      redirect_to new_user_registration_url
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = t(:auth_destroy)
    redirect_to authentications_url
  end

  def create_new_omniauth_user(omniauth)
    user = User.new
    user.apply_omniauth(omniauth, true)
    if user.save
      user
    else
      nil
    end
  end

end
