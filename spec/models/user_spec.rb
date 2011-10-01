require 'spec_helper'

describe User do

  context 'attributes' do
    it { should have_field(:time_zone).of_type(String) }

    # Stripe
    it { should have_field(:stripe_id).of_type(String) }
    it { should have_field(:last_4_digits).of_type(String) }
    it "should have a non-persisted `stripe_token`" do
      user = Factory(:user)
      user.stripe_token = 'fake token'
      user.stripe_token.should == 'fake token'
      user.stub(:update_stripe)
      user.save

      User.find(user.id).stripe_token.should be_nil
    end
  end

  context 'indexes' do
    it { should have_index_for(:email).with_options(unique: true) }

  end

  context 'validations' do
    it { should_not validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:password).within(6..32) }
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

  end
  
  it "should have access to the house it belongs to" do
    house = House.new(:name => "House")
    user = Factory.build(:user, :house => @house)
    user.should respond_to(:house)
  end
end
