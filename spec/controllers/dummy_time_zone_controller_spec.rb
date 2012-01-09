require 'spec_helper'

# Mock a Controller
class DummyTimeZoneController < ApplicationController
  def test
    render :text => Time.zone.name
  end
end

describe DummyTimeZoneController do 

  def with_dummy_routing
    with_routing do |set|
      set.draw do
        match 'dummy_time_zone/test' => 'dummy_time_zone#test'
      end
      yield
    end
  end

  context 'Time.zone' do
    it 'should default to Eastern time' do
      Time.zone.name.should == "Eastern Time (US & Canada)"
    end

    context 'when a user is signed in' do
      let(:user) { Factory.create(:user) }
      before do
        sign_in user
      end

      it "should use the user's preferred time zone" do
        user.update_attribute(:time_zone, "Paris")
        with_dummy_routing { get :test }
        response.body.should == "Paris"
      end

      it "should use the default if the user doesn't have a time zone set" do
        user.update_attribute(:time_zone, "")
        with_dummy_routing { get :test }
        response.body.should == "Eastern Time (US & Canada)"
      end
    end
  end
  
end

