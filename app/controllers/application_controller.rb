class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_sign_in, :set_locale

  # preventing modals from loading entire pages
  layout proc { |controller| controller.request.xhr? ? false : 'application' }

  protected

  def set_locale
    I18n.locale = infer_locale
  end

  def infer_locale
    if params[:locale].present?
      params[:locale]
    elsif user_signed_in?
      current_user.locale
    else
      I18n.default_locale
    end
  end

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
    flash[:reward] = "Hey look, you just got a reward for #{t(type, :scope => :rewards)}!"
  end

  private
  def prepare_sign_in
    @user = User.new
  end
end
