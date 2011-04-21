class AssignmentsController < ApplicationController
 
  # user need to be signed in
  before_filter :authenticate_user!

  # returning a list of all roomies for these actions only
  before_filter :roomies_list #, :only => [:new, :create, :edit, :update]
   
  def index
    if user_signed_in? && !current_user.house.blank?
      @house = current_user.house
      @assignments = @house.assignments
    end
    @assignments = Assignment.all
 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assignments }
    end
  end
 
  def show
    @assignment = Assignment.find(params[:id])
 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assignment }
    end
  end
 
  def new
    # @assignment = Assignment.new
 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assignment }
    end
  end
 
  def edit
    @assignment = Assignment.find(params[:id])
  end
 
  def create
    unless current_user.house.nil?
      params[:assignment][:assignees] = Array.wrap(params[:assignment][:assignees].split(','))
      @assignment = AssignmentFactory.new(params[:assignment])
 
      respond_to do |format|
        if @assignment.save
          format.html { redirect_to '/corkboard', :notice => 'Assignment was successfully created.' }
          format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
        end
      end  
    else
      redirect_to current_user, :notice => 'Sorry, you need to build a house before you can create assignments.'
    end
  end
 
  def update
    @assignment = Assignment.find(params[:id])
 
    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to(@assignment, :notice => 'Assignment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
 
    respond_to do |format|
      format.html { redirect_to(assignments_url) }
      format.xml  { head :ok }
    end
  end
 
  private
  def roomies_list 
    @roomies = User.where(:house_id => current_user.house_id)
  end
end

