class InvitationsController < ApplicationController

  respond_to :html, :json

  def index
    @invitations = Invitation.all

    respond_with @invitations
  end

  def show
    @invitation = Invitation.find(params[:id])

    respond_with @invitation
  end

  def new
    @invitation = Invitation.new

    respond_with @invitation
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    invitee = User.where(:email => @invitation.email).first || User.new

    unless invitee.house == current_user.house
      respond_to do |format|
        if @invitation.save
          format.html { redirect_to current_user, :notice => 'Invitation was successfully sent.' }
          format.xml  { render :xml => @invitation, :status => :created, :location => @invitation }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @invitation.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to current_user, :notice => "Sorry, the person you invited already lives with you."
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    
    flash[:notice] = t('.invitation_destroyed')
    redirect_to invitations_url
  end
end
