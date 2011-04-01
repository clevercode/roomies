require "spec_helper"

describe TascsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/tascs" }.should route_to(:controller => "tascs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/tascs/new" }.should route_to(:controller => "tascs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/tascs/1" }.should route_to(:controller => "tascs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/tascs/1/edit" }.should route_to(:controller => "tascs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/tascs" }.should route_to(:controller => "tascs", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/tascs/1" }.should route_to(:controller => "tascs", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/tascs/1" }.should route_to(:controller => "tascs", :action => "destroy", :id => "1")
    end

  end
end
