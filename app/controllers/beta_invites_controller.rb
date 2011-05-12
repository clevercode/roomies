class BetaInvitesController < ApplicationController

  respond_to :html

  def new
    @invite = BetaInvite.new
  end

  def create
    @invite = BetaInvite.new(params[:beta_invite])
    @invite.sender = current_user

    if @invite.save
      if user_signed_in?
        UserMailer.beta_invite(@invite, beta_sign_up_url(@invite.token)).deliver
        flash[:notice] = t('.beta_invite_sent')
        redirect_to corkboard_index_url
      else
        flash[:notice] = t('.beta_invite_request_sent')
        redirect_to root_url
      end
    else
      render :new
    end
  end

end
