class PagesController < ApplicationController
  def home
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

end
