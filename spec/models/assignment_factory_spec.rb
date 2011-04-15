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
      :category => 'General',
      :due_at => 'Thu, 24 Apr 2011 19:18:59 -0400',
      :commissioned_at => 'Thu, 14 Apr 2011 19:18:59 -0400',
      :validated_at => '',
      :assignees => [@user.id],
      :repeating => 'no',
      :frequency => '',
      :cost => 2
    }

    @assignment = AssignmentFactory.new(@params)
  end

  it 'should create a new assignement with valid parameters' do
    @assignment.should be_valid
  end

  it 'should not work with no paramters' do
    @empty_params = {}
    @empty_assignment = AssignmentFactory.new(@empty_params)
    @empty_assignment.should_not be_valid
  end

  it 'should be an expense' do
    @assignment.should be_a Expense
  end
end
