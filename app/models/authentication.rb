require 'digest/md5'

class Authentication
  include Mongoid::Document

  # Fields
  field :provider, :type => String
  field :uid, :type => String

  # Associations
  belongs_to :user


  def self.find_or_create_with_omniauth(omniauth)
    auth = find_or_initialize_by(
      provider: omniauth['provider'],
      uid: omniauth['uid']
    )
    # If we found one return it now
    return auth if auth.persisted?
    
    # Create the user from the omniauth details
    auth.find_or_create_user_with_omniauth(omniauth)
    
    auth
  end
  
  # Builds a new user with details from omniauth and sets it to self.user
  # @param omniauth - An OmniAuth info hash
  def build_user_with_omniauth(omniauth)
    info = omniauth['info']
    self.user = User.new(
      name: info['name'].presence || "Unnamed User",
      email: info['email'].presence || generate_temporary_email(omniauth),
      password: String::RandomString(16)
    )
  end

  # Builds a new user with details from omniauth and saves 
  # @see #build_user_with_omniauth
  def create_user_with_omniauth(omniauth)
    build_user_with_omniauth(omniauth).save && save
  end

  # Finds or builds a user based on the email in the omniauth hash
  def find_or_build_user_with_omniauth(omniauth)
    self.user = User.find_by_omniauth_email(omniauth) or
      build_user_with_omniauth(omniauth)
  end

  # Finds or creates a user based on the email in the omniauth hash
  def find_or_create_user_with_omniauth(omniauth)
    self.user = User.find_by_omniauth_email(omniauth) or
      create_user_with_omniauth(omniauth)
  end

  def user_created_today?
    user.created_at.today?
  end

  private 

  def generate_temporary_email(omniauth)
    '%s-%s@roomiesapp.com' % [omniauth['provider'],
                              Digest::MD5.hexdigest(omniauth['uid'])]
  end
end
