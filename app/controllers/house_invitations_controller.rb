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

    # finding the existing user matching the invitation email
    # or create a new one from scratch with email
    house_invitee = User.find_or_create_by(email: @house_invitation.email)

    # only sending the invitation if the invitee isn't already a roomie
    unless house_invitee.house == current_user.house
      if @house_invitation.save
        reward
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
