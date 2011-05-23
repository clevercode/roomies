require 'spec_helper'

describe PagesController do

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'privacy'" do
    it "should be successful" do
      get 'privacy'
      response.should be_success
    end
  end

  describe "GET 'service'" do
    it "should be successful" do
      get 'service'
      response.should be_success
    end
  end

end
