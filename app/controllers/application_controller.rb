class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_sign_in
  layout proc { |controller| controller.request.xhr? ? false : 'application' }

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  protected
  def after_sign_in_path_for(user)
    puts "called from after_sign_in_path"
    reward(nil, 1)
    corkboard_index_url
  end
  
  def reward(type, points)
    type ||= (self.controller_name + "_" + self.action_name).to_sym
    Reward.create( 
                  :user => current_user, 
                  :type => type,
                  :points => points
    )
    flash[:reward] = "Hey look, you just got a reward for #{t(type, :scope => :rewards)}!"
    flash[:error] = "Gets crowded in there when there's more than one notice..."
  end

  private
  def prepare_sign_in
    @user = User.new
  end
end
