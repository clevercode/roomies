require 'spec_helper'

describe UsersController do

  context 'GET #show' do
    context 'when signed in' do
      let(:user) { Factory.create(:user) }
      before do
        sign_in user
      end

      context 'without a user id' do
        before do
          get :show
        end

        it { should respond_with(:success) }
        it { should render_template(:show) }
        it { should assign_to(:user).with(user) }
      end

      context 'with a user id' do
        let(:other_user) { Factory.create(:user) }
        before do
          get :show, :id => other_user.to_param
        end

        it { should respond_with(:success) }
        it { should render_template(:show) }
        it { should assign_to(:user).with(other_user) }
      end
    end
  end
end
