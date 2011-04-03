class TascsController < ApplicationController
  
  # returning a list of all users for these actions only
  before_filter :user_list, :only => [:new, :create, :edit, :update]

  # GET /tascs
  # GET /tascs.xml
  def index
    @tascs = Tasc.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tascs }
    end
  end

  # GET /tasc/1
  # GET /tasc/1.xml
  def show
    @tasc = Tasc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tasc }
    end
  end

  # GET /tascs/new
  # GET /tascs/new.xml
  def new
    @tasc = Tasc.new
    @users = User.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tasc }
    end
  end

  # GET /tascs/1/edit
  def edit
    @tasc = Tasc.find(params[:id])
  end

  # POST /tascs
  # POST /tascs.xml
  def create
    @tasc = Tasc.new(params[:tasc])
    user = User.find( params[:tasc].delete(:assignees) )
    assignee = Assignee.new
    assignee.user = user
    assignee.assignable = @tasc
    assignee.save

    respond_to do |format|
      if @tasc.save
        format.html { redirect_to(@tasc, :notice => 'Tasc was successfully created.') }
        format.xml  { render :xml => @tasc, :status => :created, :location => @tasc }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tasc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tascs/1
  # PUT /tascs/1.xml
  def update
    @tasc = Tasc.find(params[:id])
    user = User.find( params[:tasc].delete(:assignees) )
    assignee = Assignee.new
    assignee.user = user
    # assignee.assignable = @tasc
    assignee.save

    respond_to do |format|
      if @tasc.update_attributes(params[:tasc])
        format.html { redirect_to(@tasc, :notice => 'Tasc was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tasc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tascs/1
  # DELETE /tascs/1.xml
  def destroy
    @tasc = Tasc.find(params[:id])
    @tasc.destroy

    respond_to do |format|
      format.html { redirect_to(tascs_url) }
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
