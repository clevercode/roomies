class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_sign_in

  private
  def prepare_sign_in
    @user = User.new
  end
end
