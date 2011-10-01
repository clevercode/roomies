class SubscriptionsController < ApplicationController

  def new
    @house = current_user.house
    render :new
  end

  def create
    @house = current_user.house
    redirect_to current_user_url, notice: "Your house is already sponsored." and return if @house.sponsored?
    if params[:stripe_token].present?
      current_user.stripe_token = params[:stripe_token]
      current_user.save
    end
    if current_user.billing.active_card.present?
      @house.sponsor = current_user
      if @house.save
        flash[:notice] = 'Thanks for sponsoring!'
      else
        flash[:failure] = 'There was an error with your billing'
      end
    end

    redirect_to current_user_url
  end


  def destroy
    house = current_user.house
    if house.sponsor = current_user
      house.sponsor = nil
    end
    if house.save
      flash[:notice] = "You are no longe sponsoring #{house.name}"
    else
      flash[:failure] = "There was a problem canceling your subscription. Please contact support."
    end
    redirect_to current_user_url
  end
end
