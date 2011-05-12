class HousesController < ApplicationController

  respond_to :html, :json

  def index
    @houses = House.all

    respond_with @houses
  end

  def show
    @house = House.find(params[:id])
    
    respond_with @house
  end

  def new
    @house = House.new

    respond_with @house
  end

  def edit
    @house = House.find(params[:id])
  end

  def create
    @house = House.new(params[:house])

    if @house.save
      current_user.house = @house
      current_user.save
      flash[:notice] = t('.house_created')
      redirect_to current_user
    else
      flash[:error] = t('.house_creation_failure')
      redirect_to current_user
    end
  end

  def update
    @house = House.find(params[:id])
    unless params[:house][:users].blank?
      user = User.find( params[:house].delete(:users) )
      user.house = @house
      user.save
    end

    if @house.update_attributes(params[:house])
      flash[:notice] = t('.house_updated')
      respond_with current_user
    else
      flash[:error] = t('.house_not_updated')
      render :edit
    end

  end

  def destroy
    @house = House.find(params[:id])
    @house.destroy

    flash[:notice] = t('.house_destroyed')
    redirect_to houses_url
  end

  def destroy_roomie
    user = User.find( params[:id] )
    user.house_id = nil
    user.save

    house = House.find( params[:house_id] )
    flash[:notice] = t('.house_destroyed')
    redirect_to current_user
  end
end
