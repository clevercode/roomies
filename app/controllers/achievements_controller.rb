class AchievementsController < ApplicationController

  respond_to :html, :json
  
  def index
    @achievements = current_user.achievements

    respond_with @achievements
  end

  def show
    @achievement = Achievement.find(params[:id])

    respond_with @achievement
  end

  def new
    @achievement = Achievement.new

    respond_with @achievement
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def create
    @achievement = Achievement.new(params[:achievement])

    if @achievement.save
      flash[:notice] = t('.achievement_created')
      redirect_to @achievement
    else
      flash[:notice] = t(:oops)
      render :new
    end
  end

  def update
    @achievement = Achievement.find(params[:id])

    if @achievement.update_attributes(params[:achievement])
      flash[:notice] = t('.achievement_updated')
      redirect_to @achievement
    else
      flash[:notice] = t(:oops)
      render :new
    end
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    @achievement.destroy

    flash[:notice] = t('.achievement_destroyed')
    redirect_to achievements_url
  end
end
