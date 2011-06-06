class RewardsController < ApplicationController

  respond_to :html, :json

  def index
    @rewards = current_user.rewards.where(past_reward: false)
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
  
  def past_rewardarize
    @rewards = current_user.rewards
    @rewards.each do |reward|
      reward.past_reward = true
      reward.save
    end
    
    render '/corkboard'
  end
end
