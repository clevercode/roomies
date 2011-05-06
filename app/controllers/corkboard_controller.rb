class CorkboardController < ApplicationController

  before_filter :authenticate_user!
  def index

    @all = Assignment.house(current_user.house)
    @past_due = @all.past_due
    @my = @all.where(assignee_ids: [current_user.id])
    @tasks = @all.where(type: "task")
    @expenses = @all.where(type: "expense")

    @todays_assignments = @all.where(due_date: Date.today.to_s)
    @tomorrows_assignments = @all.where(due_date: Date.tomorrow.to_s)
    @next_days_assignments = @all.where(due_date: Date.tomorrow.tomorrow.to_s)
    
  end
end
