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
    if @user.house
      @tasks = @user.house.assignments.where(assignee_ids: [@user.id], type: "task", completed_at: nil)
      @expenses = @user.house.assignments.where(assignee_ids: [@user.id], type: "expense", completed_at: nil)
    end
    respond_with(@user)
  end

  def new
    @user = User.new
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
    
    # @user.locale = params[:user][:locale]
    # @user.save

    if @user.update_attributes(params[:user])

      sign_in(@user, :bypass => true)
      flash[:notice] = t(:profile_updated)
      redirect_to current_user
    else
      if User.where(email: params[:email]).first != @user
        flash[:notice] = t(:address_used)
        redirect_to current_user
      else
        flash[:error] = t(:oops)
        redirect_to current_user
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    render :index
  end

  def accept_house_invitation
    house_invitation = HouseInvitation.where(:email => current_user.email).first
    house_inviter = User.find(house_invitation.house_inviter_id)
    current_user.house = house_inviter.house
    
    if current_user.save
      HouseInvitation.where(:email => current_user.email).destroy
      flash[:notice] = t('.house_joined')
      redirect_to current_user
    else
      flash[:notice] = t('.house_join_fail')
      redirect_to root_url
    end
  end
  
  def reject_house_invitations
    HouseInvitation.where(:email => current_user.email).destroy
    flash[:notice] = t('.house_join_declined')
    redirect_to root_url
  end

end
