class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_sign_in, :set_locale

  def set_locale
    logger.debug "set_locale is passed options: #{params[:locale]}\n"
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end
    

  def default_url_options(options={})
    I18n.locale = params[:locale]
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  protected
  def after_sign_in_path_for(user)
    puts "called from after_sign_in_path"
    reward(:sign_in)
    corkboard_index_url
  end
  
  def reward(type, points = nil)
    type ||= (self.controller_name + "_" + self.action_name).to_sym
    current_user.rewards.create( 
                  :type => type,
                  :points => points
    )
    flash[:reward] = "Hey look, you just got a reward for #{t(type, :scope => :rewards)}!"
  end

  private
  def prepare_sign_in
    @user = User.new
  end
end
