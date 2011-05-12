class BetaInvitesController < ApplicationController

  respond_to :html

  def new
    @invite = BetaInvite.new
  end

  def create
    @invite = BetaInvite.new(params[:beta_invite])

    if @invite.save
      flash[:notice] = t('.beta_invite_sent')
      redirect_to corkboard_index_url
    else
      render :new
    end
  end

end
