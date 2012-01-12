class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale, :set_time_zone

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

  def set_time_zone
    if user_signed_in? and current_user.time_zone.present?
      Time.zone = current_user.time_zone
    else
      Time.zone = Roomies::Application.config.time_zone
    end
  end

  def after_sign_in_path_for(user)
    reward(type: :sign_in)
    corkboard_url
  end

  def after_sign_out_path_for(user)
    sign_in_path   
  end
  
  def reward(options = {})
    user = options[:user] ||= current_user 
    type = options[:type] ||= (self.controller_name + "_" + self.action_name).to_sym
    points = options[:points] ||= nil
    user.rewards.create( 
                  :type => options[:type],
                  :user => options[:user],
                  :points => options[:points]
    )
    # flash[:reward] = "Hey look, you just got a reward for #{t(type, :scope => :rewards)}!"
  end

end
