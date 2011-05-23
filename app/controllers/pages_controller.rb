class PagesController < ApplicationController
  
  respond_to :html, :json

  def home
    @title = ""
    if user_signed_in? then redirect_to corkboard_index_url end
  end
  
  def about
    @title = "About us"
  end

  def terms
    @title = "Terms of service"
  end

  def privacy
    @title = "Privacy policy"
  end
  
  def show
    render :template => current_page
  end

  protected

    def invalid_page
      render :nothing => true, :status => 404
    end

    def current_page
      "pages/#{params[:id].to_s.downcase}"
    end
end
