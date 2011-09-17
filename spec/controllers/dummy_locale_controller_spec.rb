require 'spec_helper'

# Mock a Controller
class DummyLocaleController < ApplicationController
  def test
    render :nothing => true
  end
end

# Add the routes
Roomies::Application.routes.draw do
  match 'dummy_locale/test' => 'dummy_locale#test'
end

describe DummyLocaleController do 
  
  context 'locale inference when signed in' do
    let(:user) { ignore_mailers { Factory.create(:user) } }
    before(:each) do
      sign_in user
    end

    it 'should be set with a user preference' do
      user.update_attribute(:locale,'de')
      get :test
      I18n.locale.should == :de
    end

    it 'should be overridable via params[:locale]' do
      get :test, :locale => 'fr'
      I18n.locale.should == :fr
    end

    it 'should default to english' do
      get :test
      I18n.locale.should == :en
    end

  end

  context 'locale inference when not signed in' do
    it 'should be overridable via params[:locale]' do
      get :test, :locale => 'fr'
      I18n.locale.should == :fr
    end

    it 'should default to english' do
      get :test
      I18n.locale.should == :en
    end
  end

end
