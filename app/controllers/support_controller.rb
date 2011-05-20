class SupportController < ApplicationController
   
  def index
    render :index
  end
  
  def create
    Support.submit_request(params).deliver
    flash[:notice] = t(:sent, scope: [:support, :create])
    render :index
  end

  def show
    render :index
  end
end
