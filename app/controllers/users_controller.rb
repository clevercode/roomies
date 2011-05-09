class UsersController < ApplicationController
  # before_filter :authenticate_user!

  respond_to :html, :json

  def index
    @users = User.all
    if signed_in?
      @user = current_user
      @roomies = User.where(:house_id => @user.house_id)
    end
    if params[:name]
      @names = User.all(conditions: {name: /#{params[:name]}.*/i})
    else
      @names = ['No results']
    end
    respond_with(@users)
  end

  def show
    @user = User.find(params[:id])
    assignments = Assignment.all
    # returns assignment ID if current_user is included in assignees
    # else returns nil
    array = assignments.map { |a| a if a.assignees.include?(@user) }
    # array.compact removes all nil values from array
    @tasks = array.compact
    @expenses = []
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
    
    @user.locale = params[:user][:locale]
    @user.save

    if @user.update_attributes(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to current_user
    else
      redirect_to current_user, :notice => 'Sorry, something went horribly wrong when updating your information.'
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
    end
    
    redirect_to '/corkboard'
  end
  
  def reject_invitations
    Invitation.where(:email => current_user.email).destroy
    redirect_to '/corkboard'
  end

end
