class UsersController < ApplicationController
  def index
    @users = User.all
    respond_with :index
  end
end
