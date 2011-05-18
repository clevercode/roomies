class HouseInvitationsController < ApplicationController

  respond_to :html, :json

  def index
    @house_invitations = HouseInvitation.all

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
      respond_to do |format|
        if @house_invitation.save
          format.html { redirect_to current_user, :notice => 'House invitation was successfully sent.' }
          format.xml  { render :xml => @house_invitation, :status => :created, :location => @house_invitation }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @house_invitation.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to current_user, :notice => "Sorry, the person you invited already lives with you."
    end
  end

  def destroy
    @house_invitation = HouseInvitation.find(params[:id])
    @house_invitation.destroy
    
    flash[:notice] = t('.house_invitation_destroyed')
    redirect_to house_invitations_url
  end
end
