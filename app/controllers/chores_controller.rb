class ChoresController < ApplicationController
  
  # returning a list of all users for these actions only
  before_filter :user_list, :only => [:new, :create, :edit, :update]

  # GET /chores
  # GET /chores.xml
  def index
    @chores = Chore.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chores }
    end
  end

  # GET /chore/1
  # GET /chore/1.xml
  def show
    @chore = Chore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chore }
    end
  end

  # GET /chores/new
  # GET /chores/new.xml
  def new
    @chore = Chore.new
    @users = User.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chore }
    end
  end

  # GET /chores/1/edit
  def edit
    @chore = Chore.find(params[:id])
  end

  # POST /chores
  # POST /chores.xml
  def create
    @chore = Chore.new(params[:chore])

    respond_to do |format|
      if @chore.save
        format.html { redirect_to(@chore, :notice => 'Chore was successfully created.') }
        format.xml  { render :xml => @chore, :status => :created, :location => @chore }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chore.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chores/1
  # PUT /chores/1.xml
  def update
    @chore = Chore.find(params[:id])

    respond_to do |format|
      if @chore.update_attributes(params[:task])
        format.html { redirect_to(@chore, :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chore.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chores/1
  # DELETE /chores/1.xml
  def destroy
    @chore = Chore.find(params[:id])
    @chore.destroy

    respond_to do |format|
      format.html { redirect_to(chores_url) }
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
