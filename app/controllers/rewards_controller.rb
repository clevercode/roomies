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
    @reward.save
  end
end
