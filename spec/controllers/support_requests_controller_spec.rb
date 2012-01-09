require 'spec_helper'

describe SupportRequestsController do

  context 'GET #new' do
    before do
      get :new
    end

    it { should respond_with(:success) }
    it { should assign_to(:support_request).with_kind_of(SupportRequest) }
  end

  context 'POST #create' do

    context 'with valid params' do
      before do
        post :create, :support_request => Factory.attributes_for(:support_request) 
      end
      
      it { should redirect_to(root_url) }
      it { should set_the_flash }
      it { should have_sent_email }
    end

    context 'with invalid params' do
      before do
        post :create, :support_request => Factory.attributes_for(:support_request, :email => '') 
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end
  end

end
