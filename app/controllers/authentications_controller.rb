require 'pry'
class AuthenticationsController < ApplicationController

  def create
    # We don't need to reauthenticate if already signed in.
    if user_signed_in?
      redirect_to corkboard_url, notice: translate(:signed_in, :scope => :authentications)
      return
    end

    omniauth = request.env['omniauth.auth']
    authentication = Authentication.find_or_create_with_omniauth(omniauth)

    if authentication.user_created_today?
      flash[:notice] = translate(:welcome, :scope => :authentications)
    else
      flash[:notice] = translate(:welcome_back, :scope => :authentications)
    end

    sign_in_and_redirect(:user, authentication.user)
  end

  def failure
    flash[:error] = t(:auth_error, scope: [:authentications])
    redirect_to sign_in_url
  end
end
