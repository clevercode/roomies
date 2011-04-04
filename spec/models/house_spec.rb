require 'spec_helper'

describe House do
  before(:each) do
    @attr = { 
      :name => "House"
    }
  end
  
  it "should create a new house given valid attributes" do
    house = House.new(@attr)
    house.should be_valid
  end
  
  it "should require a name to be created" do
    house = House.new(@attr.merge(:name => ""))
    house.should_not be_valid
  end
  
  it "should accept duplicate names" do
    House.create!(@attr)
    house = House.new(@attr)
    house.should be_valid
  end
  
  it "should have access to any users who belong to it" do
    house = House.new(@attr)
    house.should respond_to(:users)
  end
end