class CorkboardController < ApplicationController

  before_filter :authenticate_user!
  def index

    @all = Assignment.where(house_id: current_user.house.id)
    @my = @all.where(assignee_ids: [current_user.id])
    @tasks = @all.where(type: "task")
    @expenses = @all.where(type: "expense")

    @todays_assignments = @all.where(due_date: Date.today.to_s)
    @tomorrows_assignments = @all.where(due_date: Date.tomorrow.to_s)
    @next_days_assignments = @all.where(due_date: Date.tomorrow.tomorrow.to_s)
    
    @past_due = []

    @all.where(completed_at: nil).map do |assignment|
      if assignment.due_date < Date.today
        @past_due << assignment
      end
    end

  end
end
