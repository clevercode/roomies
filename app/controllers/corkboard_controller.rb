class CorkboardController < ApplicationController
  def index
    @user = current_user
    @todays_assignments = Assignment.where(:due_date => Date.today.to_s)
    @tomorrows_assignments = Assignment.where(:due_date => Date.tomorrow.to_s)
    @next_days_assignments = Assignment.where(:due_date => Date.tomorrow.tomorrow.to_s)
  end
end
