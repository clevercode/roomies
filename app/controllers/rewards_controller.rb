class RewardsController < ApplicationController

  respond_to :html, :json

  def index
    @rewards = current_user.rewards
    points = @rewards.map { |r| r.points }
    @total = points.sum
  end

  def new
    @reward = Reward.new
  end

  def create 
    @reward = Reward.new(params[:reward])
    @reward.save
  end
end
