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
      assignments.select(&:task?)
    end

    def expenses
      assignments.select(&:expense?)
    end

    def due_today
      assignments.select(&:due_today?)
    end

    def due_tomorrow
      assignments.select(&:due_tomorrow?)
    end

    def due_in_two_days
      assignments.select{ |assignment| assignment.due_in?(2.days) }
    end

    def due_on(date)
      assignments.select{ |assignment| assignment.due_date == date.to_date }
    end

    def forecast
      { 
        I18n.t(:today) => due_today, 
        I18n.t(:tomorrow) => due_tomorrow, 
        I18n.l(Date.current+2, :format => :day) => due_in_two_days
      }
    end

    # TODO: Remove when refactored monthly_calendar partial
    delegate :where, to: :assignments

  end

  def show

    @all = current_user.house.assignments
    @my  = current_user.assignments
          
    @my_assignments = AssignmentsPresenter.new(@my)
    @all_assignments = AssignmentsPresenter.new(@all)

  end

  private
  
  def ensure_house!
    redirect_to house_url if current_user.house.nil?
  end
end
