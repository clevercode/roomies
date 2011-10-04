require 'spec_helper'

describe House do
  let(:house) { Factory(:house) }
  
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should_not validate_uniqueness_of(:name) }
  end

  describe '#sponsored?' do
    it "should return true when there is a sponsor" do
      user = Factory(:user)
      house.sponsor = user
      house.should be_sponsored
    end
  end

end
