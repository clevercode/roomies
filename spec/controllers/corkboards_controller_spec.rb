require 'spec_helper'

describe CorkboardsController do
  context 'CorkboardsController when signed in' do
    let(:user) { Factory.create(:user) }
    before(:each) do
      sign_in user
    end

    context 'GET #show' do
      before do
        get :show
      end

      it { should respond_with(:success) }
      it { should render_template(:show) }
    end
  end
end

