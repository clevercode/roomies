class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_sign_in

  protected
  def after_sign_in_path_for(user)
    puts "called from after_sign_in_path"
    corkboard_index_url
  end
  

  private
  def prepare_sign_in
    @user = User.new
  end
end
