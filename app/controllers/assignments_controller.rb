class AssignmentsController < ApplicationController
 
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    unless current_user.house.blank?
      @assignments = current_user.assignments
      @due         = @assignments.due
      @completed   = @assignments.completed
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
    respond_with @assignment
  end
 
  def create
    unless current_user.house.nil?
      
      house = current_user.house
      assignment = house.assignments.build(params[:assignment])
      assignment.commissioner = current_user

      # making sure the cost doesn't have letters
      # if params[:assignment][:cost]
      #   cost = params[:assignment][:cost].to_f
      #   if cost.class == Float
      #     assignment.cost = cost
      #   end
      # end

      unless assignment.duration.blank?
        if assignment.duration.is_a?(Integer)
          assignment.duration_stop = assignment.duration_stop.to_date
          
          date = assignment.due_date
          params[:assignment][:duration] = ''
          while date < assignment.duration_stop do
            if assignment.duration_length == 'Days'
              date = date + assignment.duration.days
            elsif assignment.duration_length == 'Weeks'
              date = date + assignment.duration.weeks
            else
              date = date + assignment.duration.months
            end
            params[:assignment][:due_date] = date
            Assignment.create(params[:assignment])
          end
        else
          flash[:error] = t(:invalid_duration, scope: [:assignments, :create])
          respond_with assignment, location: corkboard_index_url and return
        end
      end
      
      if assignment.save
        # assignment doesn't include current_user but at least one other assignee
        if !assignment.assignees.include?(current_user) && assignment.assignees.length >= 1
          recipients = []
          assignment.assignees.each do |user|
            recipients << user.email.to_s
          end
          UserMailer.assignment_created(assignment, recipients, "#{corkboard_index_url}/?assignment=#{assignment.id}").deliver
          reward(type: :assignments_create_lazy)
          flash[:notice] = t(:roomies_assigned, scope: [:assignments, :create])

        # assignment includes current_user & other assignees
        elsif assignment.assignees.include?(current_user) && assignment.assignees.length > 1
          recipients = []
          assignment.assignees.each do |user|
            unless user == current_user
              recipients << user.email.to_s
            end
          end
          UserMailer.assignment_created(assignment, recipients, "#{corkboard_index_url}/?assignment=#{assignment.id}").deliver
          reward(type: :assignments_create_sharing)
          flash[:notice] = t(:everyone_assigned, scope: [:assignments, :create])

        # only assignee is current_user
        elsif assignment.assignees.include?(current_user) && assignment.assignees.length == 1
          reward(type: :assignments_create_lonely)
          if current_user.house.users.count > 1
            flash[:notice] = t(:self_assigned,scope: [:assignments, :create])
          else
            flash[:notice] = t(:self_assigned_no_roomies, scope: [:assignments, :create])
          end

        # validating for presence_of assignees so this shouldn't be needed
        else
          flash[:error] = t(:no_assignees, scope: [:assignments, :create])
        end
      end
      respond_with assignment, location: corkboard_index_url
    else
      redirect_to current_user, notice: t(:build_house_before, scope: [:assignments, :create])
    end
  end
 
  def update
    @assignment = Assignment.find(params[:id])
    
    if @assignment.update_attributes(params[:assignment])
      flash[:notice] = t(:updated, scope: [:assignments, :update])
    end
    respond_with @assignment, location: corkboard_index_url
  end
 
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    flash[:notice] = t(:destroyed, scope: [:assignments, :destroy])
    respond_with @assignment
  end

  def complete
    @assignment = Assignment.find(params[:id])
    if @assignment.completed_at.nil?
      @assignment.completed_at = DateTime.now
      @assignment.completor_id = current_user.id
      if @assignment.save
        reward(user: @assignment.completor)
        flash[:notice] = t(:completed, scope: [:assignments, :complete])
      end
      respond_with @assignment, location: corkboard_index_url
    else
      flash[:notice] = t(:already_completed, scope: [:assignments, :complete])
      respond_with @assignment, location: corkboard_index_url
    end
  end

  def undo_complete
    @assignment = Assignment.find(params[:id])
    unless @assignment.completed_at.nil?
      @assignment.completed_at = nil
      reward(user: @assignment.completor)
      @assignment.completor_id = nil
      if @assignment.save
        respond_with @assignment, location: corkboard_index_url
      end
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

  def past_due_assignments
    unless current_user.house.blank?
      @past_due = current_user.assignments.past_due
      render :index
    end
  end
  
  def confirmations
    unless current_user.house.blank?
      @confirmations = current_user.assignments
                         .where(commissioner_id: current_user.id)
                         .and(:completed_at.ne => nil)
                         .excludes(completor_id: current_user.id)
      render :index
    end
  end
  
  def confirm
    @assignment = Assignment.find(params[:id])
    @assignment.validated_at = Time.now
    @assignment.validator    = current_user
    if @assignment.save
      reward
      flash[:notice] = t(:confirmed, scope: [:assignments, :confirm])
    end

    respond_with @assignment, location: corkboard_index_url
  end

  def reject
    @assignment = Assignment.find(params[:id])
    @assignment.completor = nil
    @assignment.completed_at = nil
    if @assignment.save
      reward(user: @assignment.completor)
      flash[:notice] = t(:rejected, scope: [:assignments, :reject])
    end
    respond_with @assignment, location: corkboard_index_url
    
  end
 
end

