class CorkboardController < ApplicationController

  before_filter :authenticate_user!
  def index
    @past_due = []

    @all.where(:completed_at => nil).map do |assignment|
      if assignment.due_date > Date.today
        @past_due << assignment
      end
    end

    @user = current_user
    @todays_assignments = Assignment.where(due_date: Date.today.to_s)
    @tomorrows_assignments = Assignment.where(due_date: Date.tomorrow.to_s)
    @next_days_assignments = Assignment.where(due_date: Date.tomorrow.tomorrow.to_s)
    @all_tasks = Assignment.where(house_id: current_user.house.id)
    @my_tasks = @all_tasks.where(assignee_ids: [current_user.id])
  end
end
