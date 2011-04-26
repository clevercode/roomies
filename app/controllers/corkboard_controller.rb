class CorkboardController < ApplicationController
  def index
    if signed_in?
      @user = current_user
      @todays_assignments = Assignment.where(:due_date => Date.today.to_s)
      @tomorrows_assignments = Assignment.where(:due_date => Date.tomorrow.to_s)
      @next_days_assignments = Assignment.where(:due_date => Date.tomorrow.tomorrow.to_s)
    else
      redirect_to '/users/sign_in', :notice => 'Sorry, you need to sign in before viewing that page.'
    end
  end
end
