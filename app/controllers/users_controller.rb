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
      # Tell the UserMailer to send a welcome email after save
      UserMailer.welcome_email(@user).deliver
      respond_with(@user)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to current_user, :notice => 'You just successfully changed your imformation! Yay!'
    else
      redirect_to current_user, :notice => 'Sorry, something went horribly wrong when updating your information.'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    render :index
  end

end
