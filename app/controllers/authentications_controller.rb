class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
    @u = current_user ||= "none"
  end

  def create

    omniauth = request.env['omniauth.auth']
    authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
  
    if authentication
      flash[:notice] = t(:signed_in)
      sign_in_and_redirect(:user, authentication.user)

    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = t(:auth_success)

      redirect_to authentications_url
    elsif user = create_new_omniauth_user(omniauth)
      user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = t(:signed_in)

      sign_in_and_redirect(:user, user)
    else
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
    user.apply_omniauth(omniauth)
    if user.save
      user
    else
      nil
    end
  end
end
