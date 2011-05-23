class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_sign_in, :set_locale

  # preventing modals from loading entire pages
  layout proc { |controller| controller.request.xhr? ? false : 'application' }

  def set_locale
    logger.debug "set_locale is passed options: #{params[:locale]}\n"
    # if params[:locale] is nil then I18n.default_locale will be used
    if user_signed_in?
      I18n.locale = current_user.locale || "en"
    else
      I18n.locale = "en"
    end
  end

  protected
  def after_sign_in_path_for(user)
    logger.debug "called from after_sign_in_path"
    unless self.controller_name == "invitations"
      reward(:sign_in)
    end
    corkboard_index_url
  end
  
  def reward(type, points = nil)
    type ||= (self.controller_name + "_" + self.action_name).to_sym
    current_user.rewards.create( 
                  :type => type,
                  :points => points
    )
    # flash[:reward] = "Hey look, you just got a reward for #{t(type, :scope => :rewards)}!"
  end

  private
  def prepare_sign_in
    @user = User.new
  end
end
