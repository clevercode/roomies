require 'spec_helper'

describe BetaInvite do
  before(:each) do
    @user = User.create!(
      :name => "Smoggle McSmoggleson",
      :email => "smoggle@smoggleson.com",
      :password => "muffins"
    )
  end

  it 'should create an invite given proper data' do
    invite = BetaInvite.new(
      :recipient_email => "bob@clevercode.net",
      :sender_id => @user.id,
      :token => "captain-jack-sparrow")

    invite.should be_valid
  end
end
