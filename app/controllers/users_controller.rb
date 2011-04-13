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
      respond_with(@user)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to current_user, :notice => 'You just successfully changed your profile imformation! Yay!'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    render :index
  end

end
