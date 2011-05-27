class CorkboardController < ApplicationController

  before_filter :authenticate_user!
  def index

    if current_user.house.nil?
      @all = nil
    else
      @all = current_user.house.assignments
      @my  = current_user.assignments
            
      @my_tasks                  = @my.where(type: "task")
      @my_expenses               = @my.where(type: "expense")
      @my_todays_assignments     = @my.where(due_date: Date.current.to_s)
      @my_tomorrows_assignments  = @my.where(due_date: Date.tomorrow.to_s)
      @my_next_days_assignments  = @my.where(due_date: Date.tomorrow.tomorrow.to_s)
      
      @all_tasks                 = @all.where(type: "task")
      @all_expenses              = @all.where(type: "expense")
      @all_todays_assignments    = @all.where(due_date: Date.current.to_s)
      @all_tomorrows_assignments = @all.where(due_date: Date.tomorrow.to_s)
      @all_next_days_assignments = @all.where(due_date: Date.tomorrow.tomorrow.to_s)
      
    end

    # if current_user.sign_in_count == 1
    #   flash[:notice] = "Welcome to Roomies buddy, let's get started."
    # end
  end
end
