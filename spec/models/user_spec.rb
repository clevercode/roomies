require 'spec_helper'

describe User do

  context 'attributes' do
    it { should have_field(:time_zone).of_type(String) }
  end

  context 'validations' do
    it { should_not validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it "should accept valid email addresses" do
      addresses = %w[user@email.com THE_USER@e.mail.org first.last@something.pu]
      addresses.each do |address|
        user = Factory.build(:user, :email => address)
        user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@email,com user_at_email.org first.last@email.]
      addresses.each do |address|
        user = Factory.build(:user, :email => address)
        user.should_not be_valid
      end
    end

    it "should reject email addresses identical to upcase" do
      user1 = Factory.create :user
      user2 = Factory.build :user, :email => user1.email.upcase
      user2.should_not be_valid
    end

    context "passwords" do
      let(:user) { Factory.build(:user) }

      it "should not accept passwords shorter than 6 characters" do
        user.password = 'z' * 5
        user.should_not be_valid
      end
      
      it "should not accept passwords longer than 32 characters" do
        user.password = 'z' * 33
        user.should_not be_valid
      end
    end
  end
  
  it "should have access to the house it belongs to" do
    house = House.new(:name => "House")
    user = Factory.build(:user, :house => @house)
    user.should respond_to(:house)
  end
end
