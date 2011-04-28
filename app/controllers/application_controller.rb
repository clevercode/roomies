class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_sign_in

  protected
  def after_sign_in_path_for(user)
    puts "called from after_sign_in_path"
    reward(nil, 1)
    corkboard_index_url
  end
  
  def reward(type, points)
    type ||= (self.controller_name + "_" + self.action_name).to_sym
    puts type
    Reward.create( 
                  :user => current_user, 
                  :type => type,
                  :points => points
    )
    flash[:notice] = "Hey look, you just got a reward!"
  end

  private
  def prepare_sign_in
    @user = User.new
  end
end
