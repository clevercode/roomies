class CorkboardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_house!

  # TODO: Move somewhere more appropriate
  class AssignmentsPresenter

    attr_reader :assignments

    def initialize(assignments)
      @assignments = assignments
    end

    def tasks
      assignments.select{ |assignment| assignment.type == "task" }
    end

    def expenses
      assignments.select{ |assignment| assignment.type == "expense" }
    end

    def due_today
      assignments.select{ |assignment| assignment.due_today? }
    end

    def due_tomorrow
      assignments.select{ |assignment| assignment.due_tomorrow? }
    end

    def due_in_two_days
      assignments.select{ |assignment| assignment.due_in?(2.days) }
    end

    def forecast
      { 
        I18n.t(:today) => due_today, 
        I18n.t(:tomorrow) => due_tomorrow, 
        I18n.l(Date.current+2, :format => :day) => due_in_two_days
      }
    end

  end

  def show

    @all = current_user.house.assignments
    @my  = @all.select { |assignment| assignment.assigned_to? current_user } 
          
    @my_assignments = AssignmentsPresenter.new(@my)
    @all_assignments = AssignmentsPresenter.new(@all)

  end

  private
  
  def ensure_house!
    redirect_to house_url if current_user.house.nil?
  end
end
