class SupportController < ApplicationController
   
  def index
    render :index
  end
  
  def create
    Support.submit_request(params).deliver
    render :index, :notice => 'Message sent successfully.'
  end

  def show
    render :index
  end
end
