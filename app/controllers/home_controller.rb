class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to corkboard_index_url
    end
  end

end
