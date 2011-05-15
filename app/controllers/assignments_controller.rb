class AssignmentsController < ApplicationController
 
  before_filter :authenticate_user!
  respond_to :html, :json
  autocomplete :category, :category_name

  def index
    unless current_user.house.blank?
      @assignments = current_user.house.assignments
     
      @due           = @assignments.due
      @past_due      = @assignments.past_due
      @completed     = @assignments.completed

      respond_with @assignments

    end
    
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

      house = current_user.house
      assignment = house.assignments.build(params[:assignment])
      assignment.commissioner = current_user
      
      if assignment.save
        # assignment doesn't include current_user & other assignees
        if !assignment.assignees.include?(current_user) && assignment.assignees.length >= 1
          recipients = []
          assignment.assignees.each do |user|
            recipients << user.email.to_s
          end
          UserMailer.assignment_created(assignment, recipients, corkboard_index_url(assignment.id)).deliver
          reward(nil, 2)
          flash[:notice] = "Look at you, creating assignment for other people. How about you give a hand too?"

        # assignment includes current_user & other assignees
        elsif assignment.assignees.include?(current_user) && assignment.assignees.length > 1
          recipients = []
          assignment.assignees.each do |user|
            unless user == current_user
              recipients << user.email.to_s
            end
          end
          UserMailer.assignment_created(assignment, recipients, corkboard_index_url(assignment.id)).deliver
          reward(nil, 2)
          flash[:notice] = "Sharing the workload, good thinking."

        # only assignee is current_user
        elsif assignment.assignees.include?(current_user) && assignment.assignees.length == 1
          reward(nil, 2)
          if current_user.house.users.count > 1
            flash[:notice] = "You assigned this to yourself, nice job. Give some work to your roomies, too ;-)"
          else
            flash[:notice] = "You assigned this to yourself, nice job."
          end

        # validating for presence_of assignees so this shouldn't be needed
        else
          flash[:error] = "You didn't assign anyone, let's try this again."
        end
        redirect_to '/corkboard'
      else
        redirect_to '/corkboard', :error => "Your assignment couldn't be created, try again."
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
      @assignment.completor_id = current_user.id
      if @assignment.save
        reward(nil,3)
        flash[:notice] = t(:completed, :scope => :assignments)
        respond_with(@assignment)
      else
        flash[:notice] = t(:cant_complete, :scope => :assignments)
      end
    else
      flash[:notice] = t(:already_completed, :scope => :assignments)
      respond_with @assignment
    end
  end

  def day
    day = Date.parse(params[:day])
    all = current_user.house.assignments.where(due_date: day, completed_at: nil)
    my = current_user.assignments.where(due_date: day, completed_at: nil) 
    if params[:type] == "task"
        if params[:all]
          @assignments = all.where(type: "task")
        else
          @assignments = my.where(type: "task")
        end
    elsif params[:type] == "expense"
      if params[:all]
        @assignments = all.where(type: "expense")
      else
        @assignments = my.where(type: "expense")
      end
    end
    respond_with @assignments
  end
  
  def confirmations
    unless current_user.house.blank?
      @assignments   = current_user.house.assignments
      @confirmations = @assignments
                         .where(commissioner_id: current_user.id)
                         .and(:completed_at.ne => nil)
                         .excludes(completor_id: current_user.id)
                         
      render :index
    end
  end
  
  def confirm
    assignment = Assignment.find(params[:id])
    assignment.validated_at = Time.now
    assignment.validator    = current_user
    if assignment.save
      redirect_to '/corkboard', notice: 'Assignment successfully confirmed.'
    end
    
  end

  def reject
    assignment = Assignment.find(params[:id])
    assignment.completor = nil
    assignment.completed_at = nil
    if assignment.save
      redirect_to '/corkboard', notice: 'Assignment successfully rejected.'
    end
    
  end
 
end

