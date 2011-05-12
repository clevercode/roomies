class CorkboardController < ApplicationController

  before_filter :authenticate_user!
  def index

    unless current_user.house
      @all = Assignment.house(House.create(:name => "demo"))
    else
      @all = Assignment.house(current_user.house).where(completed_at: nil)
    end
    @my  = @all.where(assignee_ids: [current_user.id]).and(completed_at: nil)
    
    @my_confirmations          = Assignment.house(current_user.house)
                                   .where(commissioner_id: current_user.id)
                                   .and(:completed_at.exists => true)
                                   .excludes(assignee_ids: [current_user.id])
    
    @my_past_due               = @my.past_due
    @my_tasks                  = @my.where(type: "task")
    @my_expenses               = @my.where(type: "expense")
    @my_todays_assignments     = @my.where(due_date: Date.today.to_s)
    @my_tomorrows_assignments  = @my.where(due_date: Date.tomorrow.to_s)
    @my_next_days_assignments  = @my.where(due_date: Date.tomorrow.tomorrow.to_s)
    
    @all_tasks                 = @all.where(type: "task")
    @all_expenses              = @all.where(type: "expense")
    @all_todays_assignments    = @all.where(due_date: Date.today.to_s)
    @all_tomorrows_assignments = @all.where(due_date: Date.tomorrow.to_s)
    @all_next_days_assignments = @all.where(due_date: Date.tomorrow.tomorrow.to_s)
    
  end
end
