require "spec_helper"

describe HouseInvitationsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/house_invitations" }.should route_to(:controller => "house_invitations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/house_invitations/new" }.should route_to(:controller => "house_invitations", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/house_invitations/1" }.should route_to(:controller => "house_invitations", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/house_invitations/1/edit" }.should route_to(:controller => "house_invitations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/house_invitations" }.should route_to(:controller => "house_invitations", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/house_invitations/1" }.should route_to(:controller => "house_invitations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/house_invitations/1" }.should route_to(:controller => "house_invitations", :action => "destroy", :id => "1")
    end

  end
end
