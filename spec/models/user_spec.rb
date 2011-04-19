require 'spec_helper'

describe User do
  before(:each) do
    @attr = { 
      :name => "Andrew Smith",
      :email => "ae@smith.com",
      :password => "muffins"
    }
  end

  it "should create a new user given valid attributes" do
    User.create!(@attr)
  end

  it "should not require a name" do
    user = User.new(@attr.merge(:name => ""))
    user.should be_valid
  end

  it "should require an email address" do
    user = User.new(@attr.merge(:email => ""))
    user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@email.com THE_USER@e.mail.org first.last@something.pu]
    addresses.each do |address|
      user = User.new(@attr.merge(:email => address))
      user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@email,com user_at_email.org first.last@email.]
    addresses.each do |address|
      user = User.new(@attr.merge(:email => address))
      user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user = User.new(@attr)
    user.should_not be_valid
  end

  it "should reject email addresses identical to upcase" do
    email = @attr[:email].upcase
    User.create!(@attr.merge(:email => email))
    user = User.new(@attr)
    user.should_not be_valid
  end

  describe "passwords" do
    before(:each) do
      @user = User.new(@attr)
    end

    it "should not accept passwords shorter than 6 characters" do
      pass = 'z' * 5
      user = User.new(@attr.merge(:password => pass))
      user.should_not be_valid
    end
    
    it "should not accept passwords longer than 32 characters" do
      pass = 'z' * 33
      user = User.new(@attr.merge(:password => pass))
      user.should_not be_valid
    end
  end
  
  it "should have access to the house it belongs to" do
    house = House.new(:name => "House")
    user = User.new(@attr.merge(:house => @house))
    user.should respond_to(:house)
  end
end
