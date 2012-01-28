require 'spec_helper'

describe Authentication do

  def mock_omniauth(opts = {})
    { 
      'uid'      => '0',
      'provider' => 'mocker',
      'info' => {
        'name' => 'Arthur Mock',
        'email' => 'arthur@example.com'
      }
    }.deep_merge!(opts)
  end

  describe '.find_or_create_with_omniauth' do

    it 'should return an existing authentication' do
      authentication = Factory.create(:authentication)
      found_authentication = Authentication.find_or_create_with_omniauth(
        mock_omniauth('uid' => authentication.uid, 
                      'provider' => authentication.provider)
      )
      found_authentication.should == authentication
    end

    it 'should create a new authentication from the omniauth hash' do
      omniauth = mock_omniauth  
      authentication = Authentication.find_or_create_with_omniauth(omniauth)

      authentication.should be_valid
      authentication.should be_persisted
      authentication.uid.should == omniauth['uid']
      authentication.provider.should == omniauth['provider']
      authentication.user.email.should == omniauth['info']['email']
    end
  end

  describe '#build_user_with_omniauth' do
    let(:authentication) { Factory.build(:authentication) } 

    it 'should set the set the name' do
      omniauth = mock_omniauth 'info' => { 'name' => 'Test Name' }
      authentication.build_user_with_omniauth(omniauth)
      authentication.user.name.should == 'Test Name' 
    end

    it 'should set the email when given' do
      omniauth = mock_omniauth 'info' => { 'email' => 'test@example.com' }
      authentication.build_user_with_omniauth(omniauth)
      authentication.user.email.should == 'test@example.com'
    end

    it 'should set the email when not given' do
      omniauth = mock_omniauth 'info' => { 'email' => '' }
      authentication.build_user_with_omniauth(omniauth)
      authentication.user.email.should be_present
    end

    it 'should set a password' do
      omniauth = mock_omniauth
      authentication.build_user_with_omniauth(omniauth)
      authentication.user.password.should be_present
    end

    it 'should build a valid user' do
      authentication.build_user_with_omniauth(mock_omniauth)
      authentication.user.should be_valid
    end

    it 'should not save the user' do
      authentication.build_user_with_omniauth(mock_omniauth)
      authentication.user.should_not be_persisted
    end

    it 'should return the user' do
      user = authentication.build_user_with_omniauth(mock_omniauth)
      authentication.user.should == user
    end

  end

  describe '#create_user_with_omniauth' do
    let(:authentication) { Factory.build(:authentication) } 

    it 'should save the user' do
      authentication.create_user_with_omniauth(mock_omniauth)
      authentication.user.should be_persisted
    end

    it 'should save the authentication' do
      # Check save status before
      authentication.should_not be_persisted

      authentication.create_user_with_omniauth(mock_omniauth)
      # Check save status after
      authentication.should be_persisted
    end

  end

  describe '#find_or_build_user_with_omniauth' do
    let(:user) { Factory.create(:user) }
    let(:authentication) { Factory.build(:authentication) } 
    
    it 'should build a new user if email does not exist' do
      authentication.find_or_build_user_with_omniauth(mock_omniauth)
      authentication.user.should_not be_persisted
    end

    it 'should build a new user if email is not provided' do
      omniauth = mock_omniauth('info' => { 'email' => '' })
      authentication.find_or_build_user_with_omniauth(omniauth)
      authentication.user.should_not be_persisted
    end

    it 'should find an existing user if email exists' do
      omniauth = mock_omniauth('info' => { 'email' => user.email })
      authentication.find_or_build_user_with_omniauth(omniauth)
      authentication.user.should == user
    end
  end

  describe '#find_or_create_user_with_omniauth' do
    let(:user) { Factory.create(:user) }
    let(:authentication) { Factory.build(:authentication) } 

    it 'should create a new user if email does not exist' do
      authentication.find_or_create_user_with_omniauth(mock_omniauth)
      authentication.user.should be_persisted
      authentication.user.should_not == user
    end

    it 'should create a new user if email is not provided' do
      omniauth = mock_omniauth('info' => { 'email' => '' })
      authentication.find_or_create_user_with_omniauth(omniauth)
      authentication.user.should be_persisted
      authentication.user.should_not == user
    end

    it 'should find an existing user if email exists' do
      omniauth = mock_omniauth('info' => { 'email' => user.email })
      authentication.find_or_create_user_with_omniauth(omniauth)
      authentication.user.should == user
    end
  end
  
  describe '#user_created_today?' do
    let(:authentication) { Factory.build(:authentication) } 

    it 'should return true when user was created today' do
      authentication.user = Factory.create(:user, created_at: Time.now)
      authentication.user_created_today?.should be_true
    end

    it 'should return false when user was not created today' do
      authentication.user = Factory.create(:user, created_at: Time.now.yesterday)
      authentication.user_created_today?.should be_false
    end
  end

  describe '#new_user?' do
    let(:authentication) { Factory.build(:authentication) } 

    it 'should return true when the user has never signed in' do
      authentication.user.sign_in_count = 0
      authentication.new_user?.should be_true
    end

    it 'should return true when the user has signed in once' do
      authentication.user.sign_in_count = 1
      authentication.new_user?.should be_true
    end

    it 'should return false when the user has signed in more than once' do
      authentication.user.sign_in_count = 2
      authentication.new_user?.should be_false
    end
  end
end
