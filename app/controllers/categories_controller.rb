class CategoriesController < ApplicationController

  respond_to :html, :json

  def index
    if params[:search]
      @categories = Category.find(:all, :conditions => { :name => params[:search] }) 
    else
      @categories = Category.all
    end

    respond_with @categories
  end
end
