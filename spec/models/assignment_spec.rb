require 'spec_helper'

describe Assignment do 
  let(:assignment) { Factory.build(:assignment) }

  describe '#due_today?' do
    it 'should be true when due date is today' do
      assignment.due_date = Date.current
      assignment.due_today?.should be_true
    end

    it 'should be false when due date is not today' do
      assignment.due_date = Date.tomorrow
      assignment.due_today?.should be_false
      assignment.due_date = Date.yesterday
      assignment.due_today?.should be_false
    end
  end

  describe '#due_today?' do
    it 'should be true when due date is tomorrow' do
      assignment.due_date = Date.tomorrow
      assignment.due_tomorrow?.should be_true
    end

    it 'should be false when due date is not tomorrow' do
      assignment.due_date = Date.current
      assignment.due_tomorrow?.should be_false
      assignment.due_date = Date.yesterday
      assignment.due_tomorrow?.should be_false
      assignment.due_date = Date.current + 2.days
      assignment.due_tomorrow?.should be_false
    end
  end

  describe '#due_today?' do
    it 'should be true when due date matches the duration' do
      assignment.due_date = Date.current + 1.day
      assignment.due_in?(1.day).should be_true
      assignment.due_date = Date.current + 1.week
      assignment.due_in?(1.week).should be_true
    end
  end
end
