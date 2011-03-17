require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe ChoresController do

  def mock_chore(stubs={})
    @mock_chore ||= mock_model(Chore, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all chores as @chores" do
      Chore.stub(:all) { [mock_chore] }
      get :index
      assigns(:chores).should eq([mock_chore])
    end
  end

  describe "GET show" do
    it "assigns the requested chore as @chore" do
      Chore.stub(:find).with("37") { mock_chore }
      get :show, :id => "37"
      assigns(:chore).should be(mock_chore)
    end
  end

  describe "GET new" do
    it "assigns a new chore as @chore" do
      Chore.stub(:new) { mock_chore }
      get :new
      assigns(:chore).should be(mock_chore)
    end
  end

  describe "GET edit" do
    it "assigns the requested chore as @chore" do
      Chore.stub(:find).with("37") { mock_chore }
      get :edit, :id => "37"
      assigns(:chore).should be(mock_chore)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created chore as @chore" do
        Chore.stub(:new).with({'these' => 'params'}) { mock_chore(:save => true) }
        post :create, :chore => {'these' => 'params'}
        assigns(:chore).should be(mock_chore)
      end

      it "redirects to the created chore" do
        Chore.stub(:new) { mock_chore(:save => true) }
        post :create, :chore => {}
        response.should redirect_to(chore_url(mock_chore))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved chore as @chore" do
        Chore.stub(:new).with({'these' => 'params'}) { mock_chore(:save => false) }
        post :create, :chore => {'these' => 'params'}
        assigns(:chore).should be(mock_chore)
      end

      it "re-renders the 'new' template" do
        Chore.stub(:new) { mock_chore(:save => false) }
        post :create, :chore => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested chore" do
        Chore.stub(:find).with("37") { mock_chore }
        mock_chore.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :chore => {'these' => 'params'}
      end

      it "assigns the requested chore as @chore" do
        Chore.stub(:find) { mock_chore(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:chore).should be(mock_chore)
      end

      it "redirects to the chore" do
        Chore.stub(:find) { mock_chore(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(chore_url(mock_chore))
      end
    end

    describe "with invalid params" do
      it "assigns the chore as @chore" do
        Chore.stub(:find) { mock_chore(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:chore).should be(mock_chore)
      end

      it "re-renders the 'edit' template" do
        Chore.stub(:find) { mock_chore(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested chore" do
      Chore.stub(:find).with("37") { mock_chore }
      mock_chore.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the chores list" do
      Chore.stub(:find) { mock_chore }
      delete :destroy, :id => "1"
      response.should redirect_to(chores_url)
    end
  end

end