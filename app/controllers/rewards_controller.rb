class RewardsController < ApplicationController

  respond_to :html, :json

  def index
    @rewards = Reward.all
  end

  def new
    @reward = Reward.new
  end

  def create 
    @reward = Reward.new(params[:reward])
    if @reward.save
      flash[:notice] = "You received a new reward"
      respond_with(@reward)
    else
      flash[:notice] = "You should have received a reward but we dropped the ball, we'll fix it soon promise."
    end
  end
end
