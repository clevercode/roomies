require 'spec_helper'

describe Assignment do
  before(:each) do
    @user = User.create!(
      :name => "Smoggle McSmoggleson",
      :email => "smoggle@smoggleson.com",
      :password => "muffins"
    )

    @params = {
      :purpose => 'Find the meaning of life',
      :due_at => 'Thu, 24 Apr 2011 19:18:59 -0400',
      :commissioned_at => 'Thu, 14 Apr 2011 19:18:59 -0400',
      :assignees => [@user.id],
      :frequency => 10,
      :cost => 1
    }

    # @assignment = AssignmentFactory.new(@params)
  end

  it 'should create a task given specific data' do
    assignment = AssignmentFactory.new(
      @params.merge(
        :cost => nil, 
        :frequency => nil
      )
    )
    assignment.should be_valid
    assignment.should be_a(Tasc)
  end

  it 'should create a chore given specific data' do
    assignment = AssignmentFactory.new(
      @params.merge(:cost => nil)
    )
    assignment.should be_valid
    assignment.should be_a(Chore)
  end

  it 'should create an expense given specific data' do
    assignment = AssignmentFactory.new(
      @params.merge(:frequency => nil)
    )
    assignment.should be_valid
    assignment.should be_a(Expense)
  end

  it 'should create a bill given specific data' do
    assignment = AssignmentFactory.new(@params)
    assignment.should be_valid
    assignment.should be_a(Bill)
  end

  it 'should create a freebie given specific data' do
    assignment = AssignmentFactory.new({
      :purpose => "Did something nice",
      :claimed_at => DateTime.new,
      :claimant_id => @user.id
    })
    assignment.should be_valid
    assignment.should be_a(Freebie)
  end

  it 'should create a bounty given specific data' do
    assignment = AssignmentFactory.new({
      :purpose => "We should fix this someday",
    })
    assignment.should be_valid
    assignment.should be_a(Bounty)
  end

  it 'should create a Gift given specific data' do
    assignment = AssignmentFactory.new({
      :purpose => "Hey I bought you something",
      :cost => 2,
      :claimed_at => DateTime.new,
      :claimant_id => @user.id
    })
    assignment.should be_valid
    assignment.should be_a(Gift)
  end

  it 'should create a Wish given specific data' do
    assignment = AssignmentFactory.new({
      :purpose => "We should buy this someday",
      :cost => 2
    })
    assignment.should be_valid
    assignment.should be_a(Wish)
  end


end
