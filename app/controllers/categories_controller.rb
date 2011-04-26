class CategoriesController < ApplicationController
  def index
    if params[:search]
      @categories = Category.find(:all, :conditions => { :name => params[:search] }) 
    else
      @categories = Category.all
    end

    respond_to do |format|
      format.html 
      format.js
    end
  end
end
