require 'spec_helper'
describe HomeController do
  context 'locale inference' do
    it 'should default to english' do
      get :index
      I18n.locale.should == :en
    end

    it 'should be overridable via params[:locale]' do
      get :index, :locale => 'fr'
      I18n.locale.should == :fr
    end
  end
end
