require "spec_helper"

describe ChoresController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/chores" }.should route_to(:controller => "chores", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/chores/new" }.should route_to(:controller => "chores", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/chores/1" }.should route_to(:controller => "chores", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/chores/1/edit" }.should route_to(:controller => "chores", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/chores" }.should route_to(:controller => "chores", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/chores/1" }.should route_to(:controller => "chores", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/chores/1" }.should route_to(:controller => "chores", :action => "destroy", :id => "1")
    end

  end
end
