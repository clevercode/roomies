require "spec_helper"

describe HousesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/houses" }.should route_to(:controller => "houses", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/houses/new" }.should route_to(:controller => "houses", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/houses/1" }.should route_to(:controller => "houses", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/houses/1/edit" }.should route_to(:controller => "houses", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/houses" }.should route_to(:controller => "houses", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/houses/1" }.should route_to(:controller => "houses", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/houses/1" }.should route_to(:controller => "houses", :action => "destroy", :id => "1")
    end

  end
end
