class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
    else
      @users = User.all
    end
  end

end
