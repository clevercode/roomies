class UsersController < ApplicationController
  # before_filter :authenticate_user!

  respond_to :html, :json

  def index
    @users = User.all
    if signed_in?
      @user = current_user
      @roomies = User.where(:house_id => @user.house_id)
    end
    respond_with(@users)
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.assignments.where(type: "task", completed_at: nil)
    @expenses = @user.assignments.where(type: "expense", completed_at: nil)
    respond_with(@user)
  end

  def new
    @user = User.new(:invite_token => params[:invite_token])
    @user.email = @user.beta_invite.recipient_email if @user.beta_invite
    respond_with(@user)
  end

  def edit
    @user = User.find(params[:id])
    respond_with(@user)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      respond_with(@user)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    
    @user.locale = params[:user][:locale]
    @user.save

    if @user.update_attributes(params[:user])

      sign_in(@user, :bypass => true)
      redirect_to current_user, :notice => '.profile_successfully_updated'
    else
      if User.where(email: params[:email]).first != @user
        redirect_to current_user, :notice => '.address_already_used.'
      else
        redirect_to current_user, :notice => '.something_went_wrong'
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    render :index
  end

  def accept_invitation
    invitation = Invitation.where(:email => current_user.email).first
    inviter = User.find(invitation.inviter_id)
    current_user.house = inviter.house
    
    if current_user.save
      Invitation.where(:email => current_user.email).destroy
      flash[:notice] = t('.house_joined')
      respond_with current_user
    else
      flash[:notice] = t('.house_join_fail')
      redirect_to corkboard_index_url
    end
  end
  
  def reject_invitations
    Invitation.where(:email => current_user.email).destroy
    flash[:notice] = t('.house_join_declined')
    redirect_to corkboard_index_url
  end

end
