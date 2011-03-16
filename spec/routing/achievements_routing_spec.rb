require "spec_helper"

describe AchievementsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/achievements" }.should route_to(:controller => "achievements", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/achievements/new" }.should route_to(:controller => "achievements", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/achievements/1" }.should route_to(:controller => "achievements", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/achievements/1/edit" }.should route_to(:controller => "achievements", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/achievements" }.should route_to(:controller => "achievements", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/achievements/1" }.should route_to(:controller => "achievements", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/achievements/1" }.should route_to(:controller => "achievements", :action => "destroy", :id => "1")
    end

  end
end
