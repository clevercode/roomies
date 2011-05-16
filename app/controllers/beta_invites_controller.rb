class BetaInvitesController < ApplicationController

  respond_to :html

  def new
    @invite = BetaInvite.new
  end

  def create
    @invite = BetaInvite.new(params[:beta_invite])

    # making sure there aren't existing invites with this recipient
    if BetaInvite.where(recipient_email: params[:beta_invite][:recipient_email]).first.blank?

      @invite.sender = current_user if user_signed_in?

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
        flash[:error] = "Couldn't create an beta invite, drop us a line so we fix this. Sorry."
        render :new
      end
    else
      flash[:error] = "Someone already requested an invite for this email address"
      redirect_to "#{root_url}/?beta=true"
    end
  end

end
