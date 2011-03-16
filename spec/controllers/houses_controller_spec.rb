require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe HousesController do

  def mock_house(stubs={})
    @mock_house ||= mock_model(House, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all houses as @houses" do
      House.stub(:all) { [mock_house] }
      get :index
      assigns(:houses).should eq([mock_house])
    end
  end

  describe "GET show" do
    it "assigns the requested house as @house" do
      House.stub(:find).with("37") { mock_house }
      get :show, :id => "37"
      assigns(:house).should be(mock_house)
    end
  end

  describe "GET new" do
    it "assigns a new house as @house" do
      House.stub(:new) { mock_house }
      get :new
      assigns(:house).should be(mock_house)
    end
  end

  describe "GET edit" do
    it "assigns the requested house as @house" do
      House.stub(:find).with("37") { mock_house }
      get :edit, :id => "37"
      assigns(:house).should be(mock_house)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created house as @house" do
        House.stub(:new).with({'these' => 'params'}) { mock_house(:save => true) }
        post :create, :house => {'these' => 'params'}
        assigns(:house).should be(mock_house)
      end

      it "redirects to the created house" do
        House.stub(:new) { mock_house(:save => true) }
        post :create, :house => {}
        response.should redirect_to(house_url(mock_house))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved house as @house" do
        House.stub(:new).with({'these' => 'params'}) { mock_house(:save => false) }
        post :create, :house => {'these' => 'params'}
        assigns(:house).should be(mock_house)
      end

      it "re-renders the 'new' template" do
        House.stub(:new) { mock_house(:save => false) }
        post :create, :house => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested house" do
        House.stub(:find).with("37") { mock_house }
        mock_house.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :house => {'these' => 'params'}
      end

      it "assigns the requested house as @house" do
        House.stub(:find) { mock_house(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:house).should be(mock_house)
      end

      it "redirects to the house" do
        House.stub(:find) { mock_house(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(house_url(mock_house))
      end
    end

    describe "with invalid params" do
      it "assigns the house as @house" do
        House.stub(:find) { mock_house(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:house).should be(mock_house)
      end

      it "re-renders the 'edit' template" do
        House.stub(:find) { mock_house(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested house" do
      House.stub(:find).with("37") { mock_house }
      mock_house.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the houses list" do
      House.stub(:find) { mock_house }
      delete :destroy, :id => "1"
      response.should redirect_to(houses_url)
    end
  end

end
