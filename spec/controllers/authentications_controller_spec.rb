require 'spec_helper'
describe AuthenticationsController do

  before do
    OmniAuth.config.test_mode = true
  end
  let(:user){ Factory.create(:user, created_at: Time.now.yesterday) } 

  describe 'GET #create' do
    context 'when signed in' do
      before do
        sign_in user
        get :create, provider: 'test'
      end

      it { should redirect_to(corkboard_url) }
      it { should set_the_flash.to(/already signed in/) }
    end

    context 'with existing user' do
      before do
        OmniAuth.config.add_mock :test, {'info' => { 'email' => user.email }}
        request.env['omniauth.auth'] = OmniAuth.mock_auth_for('test')
        get :create, provider: 'test'
      end

      it { should redirect_to(corkboard_url) }
      it { should set_the_flash.to(/welcome back/i) }

    end

    context 'with new user' do

      before do
        OmniAuth.config.add_mock :test, {'info' => { 'email' => 'user@example.com' }}
        request.env['omniauth.auth'] = OmniAuth.mock_auth_for('test')
        get :create, provider: 'test'
      end

      it { should redirect_to(corkboard_url) }
      it { should set_the_flash.to(/welcome to Roomies/i) }

    end
  end
end
