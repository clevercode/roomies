class FacebookController < ApplicationController
  def setup
    # making sure we're just asking for basic user info & email, nothing more
    session[:fb_permissions] = 'email'
    request.env['omniauth.strategy'].options[:scope] = session[:fb_permissions]
    render :text => "Setup complete.", :status => 404
  end
end
