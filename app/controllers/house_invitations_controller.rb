class HouseInvitationsController < ApplicationController

  respond_to :html, :json

  def index
    @house_invitations = HouseInvitation.where(email: current_user.email)
    respond_with @house_invitations
  end

  def show
    @house_invitation = HouseInvitation.find(params[:id])
    respond_with @house_invitation
  end

  def new
    @house_invitation = HouseInvitation.new
    respond_with @house_invitation
  end

  def create
    @house_invitation = HouseInvitation.new(params[:house_invitation])
    house_invitee = User.where(:email => @house_invitation.email).first || User.new

    unless house_invitee.house == current_user.house
      if @house_invitation.save
        flash[:notice] = t('.house_invitation_sent')
      end
      respond_with @house_invitation, location: current_user
    else
      flash[:notice] = t('.already_roomie')
      redirect_to current_user
    end
  end

  def destroy
    @house_invitation = HouseInvitation.find(params[:id])
    @house_invitation.destroy
    
    flash[:notice] = t('.house_invitation_destroyed')
    respond_with @house_invitation, location: current_user
  end
end
