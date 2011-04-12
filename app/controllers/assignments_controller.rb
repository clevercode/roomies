class AssignmentsController < ApplicationController
 
  # user need to be signed in
  before_filter :authenticate_user!

  # returning a list of all users for these actions only
  before_filter :user_list #, :only => [:new, :create, :edit, :update]
   
  # GET /assignments
  # GET /assignments.xml
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
 
  # GET /assignments/1
  # GET /assignments/1.xml
  def show
    @assignment = Assignment.find(params[:id])
 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assignment }
    end
  end
 
  # GET /assignments/new
  # GET /assignments/new.xml
  def new
    @assignment = Assignment.new
    @roomies = User.where(:house => current_user.house)
 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assignment }
    end
  end
 
  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
  end
 
  # POST /assignments
  # POST /assignments.xml
  def create
    @assignment = Assignment.new(params[:assignment])
 
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to(@assignment, :notice => 'Assignment was successfully created.') }
        format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  # PUT /assignments/1
  # PUT /assignments/1.xml
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
 
  # DELETE /assignments/1
  # DELETE /assignments/1.xml
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
 
    respond_to do |format|
      format.html { redirect_to(assignments_url) }
      format.xml  { head :ok }
    end
  end
 
  private
  # making the user list accessible not only to new and edit
  # but also to create and update in case errors arise
  # (if declared inside an action, the instance variable was
  # not accessible to others and broke the user select).
  def user_list 
    @users = User.all
  end
end

