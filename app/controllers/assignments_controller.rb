class AssignmentsController < ApplicationController
 
  before_filter :authenticate_user!
  respond_to :html, :json
  autocomplete :category, :category_name

  def index
    if user_signed_in? && !current_user.house.blank?
      @house = current_user.house
      @assignments = @house.assignments
    end
    
    past_assignments = []
    Assignment.where(:completed_at => nil).order_by([:due_date, :asc]).map do |assignment|
      if assignment.due_date < Date.today
        past_assignments.push assignment
      end
    end
    
    @assignments = past_assignments
 
    respond_with @assignments
  end
 
  def show
    @assignment = Assignment.find(params[:id])
 
    respond_with @assignment
  end
 
  def new
    @assignment = Assignment.new

    respond_with @assignment
  end
 
  def edit
    @assignment = Assignment.find(params[:id])
  end
 
  def create
    unless current_user.house.nil?
      params[:assignment][:house_id]        = current_user.house_id
      params[:assignment][:commissioner_id] = current_user.id
      params[:assignment][:commissioned_at] = Time.now

      # passing the params through AssignmentFactory to receive
      # the appropriate assignment type
      @assignment = Assignment.new(params[:assignment])

      if @assignment.save
        reward(nil, 2)
        redirect_to '/corkboard'
      else
        redirect_to '/corkboard', :notice => "Your assignment couldn't be created, try again."
      end

    else
      redirect_to current_user, :notice => 'Sorry, you need to build a house before you can create assignments.'
    end
  end
 
  def update
    @assignment = Assignment.find(params[:id])

    if @assignment.update_attributes(params[:assignment])
      flash[:notice] = "Your assignment was successfully updated."
    else
      flash[:notice] = "Your assignment couldn't be updated, try again."
    end

    respond_with @assignment
  end
 
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    flash[:notice] = "Your assignment was successfully destroyed"

    respond_with @assignment
  end

  def complete
    @assignment = Assignment.find(params[:id])
    if @assignment.completed_at.nil?
      @assignment.completed_at = DateTime.now
      if @assignment.save
        reward(nil,3)
        flash[:notice] = t(:completed, :scope => :assignments)
        respond_with(@assignment)
      else
        flash[:notice] = t(:cant_complete, :scope => :assignments)
      end
    else
      flash[:notice] = t(:already_completed, :scope => :assignments)
      respond_with(@assignment)
    end
  end
 
end

