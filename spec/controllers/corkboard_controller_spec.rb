require 'spec_helper'
describe CorkboardController do

  context 'locale inference' do
    let(:user) { Factory.create(:user) }
    before(:each) do
      sign_in user
    end

    it 'should be set with a user preference' do
      user.update_attribute(:locale,'de')
      get :index
      I18n.locale.should == :de
    end

    it 'should be overridable via params[:locale]' do
      get :index, :locale => 'fr'
      I18n.locale.should == :fr
    end

    it 'should default to english' do
      get :index
      I18n.locale.should == :en
    end

  end
end
