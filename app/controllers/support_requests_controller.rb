# TODO: Investigate why this is needed to pass tests.
#       Perhaps it's being unloaded.
require 'support_request'

class SupportRequestsController < ApplicationController

  def new
    @support_request = SupportRequest.new
    render :new
  end
   
  def create
    @support_request = SupportRequest.new(params[:support_request])
    if @support_request.save
      flash[:notice] = t(:sent, scope: [:support, :create])
      redirect_to root_url
    else
      render :new
    end
  end

end
