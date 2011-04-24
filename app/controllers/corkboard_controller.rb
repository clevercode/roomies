class CorkboardController < ApplicationController
  def index
    @user = current_user
    @freebies = Freebie.where(:house_id => current_user.house_id)
    @bounties = Bounty.where(:house_id => current_user.house_id)
    @gifts = Gift.where(:house_id => current_user.house_id)
    @wishes = Wish.where(:house_id => current_user.house_id)

    @tasks = Tasc.where(:house_id => current_user.house_id)
    @expenses = Expense.where(:house_id => current_user.house_id)
    @bills = Bill.where(:house_id => current_user.house_id)
    @chores = Chore.where(:house_id => current_user.house_id)
    
    @todays_assignments = Assignment.where(:due_date => Date.today.to_s)
    @tomorrows_assignments = Assignment.where(:due_date => Date.tomorrow.to_s)
    @next_days_assignments = Assignment.where(:due_date => Date.tomorrow.tomorrow.to_s)
  end
end
