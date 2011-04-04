class User 
  include Mongoid::Document
  require 'digest/md5'

  # Fields
  field :name, :type => String
  field :created_at, :type => DateTime

  # Associations
  has_many :authentications, :dependent => :delete # User has access to an array of Authentications that have its id for user_id
  belongs_to :house # => User has a house_id
  has_many :assignees # User has access to an array of Assignees that have its id for user_id

  # Devise
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :remember_me

  ###
  # user methods
  ###
  
  def apply_omniauth(omniauth, confirmation)
    self.email = omniauth['user_info']['email'] if email.blank?
    # Check if email is already into the database => user exists
    apply_trusted_services(omniauth, confirmation) if self.new_record?
  end
  
  # Create a new user
  def apply_trusted_services(omniauth, confirmation)  
    # Merge user_info && extra.user_info
    user_info = omniauth['user_info']

    if omniauth['extra'] && omniauth['extra']['user_hash']
      user_info.merge!(omniauth['extra']['user_hash'])
    end  

    # try name or nickname
    if self.name.blank?
      self.name   = user_info['name'] unless user_info['name'].blank?
      self.name ||= user_info['nickname'] unless user_info['nickname'].blank?
      self.name ||= (user_info['first_name'] + " " + user_info['last_name']) unless \
        user_info['first_name'].blank? || user_info['last_name'].blank?
    end   

    if self.email.blank?
      self.email = user_info['email'] unless user_info['email'].blank?
    end  

    # Set a random password for omniauthenticated users
    self.password, self.password_confirmation = String::RandomString(16)

    if (confirmation) 
      self.confirmed_at, self.confirmation_sent_at = Time.now  
    end 
  end

  ###
  # Override methods
  ###

  def update_with_password(params={})
    current_password = params.delete(:current_password)
    check_password = true
    if params[:password].blank?
      params.delete(:password)
      if params[:password_confirmation].blank?
        params.delete(:password_confirmation)
        check_password = false
      end 
    end
    result = if valid_password?(current_password) || !check_password
      update_attributes(params)
    else
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      self.attributes = params
      false
    end
    clean_up_passwords
    result
  end
  

  def to_s
    self.name || self.email
  end
  
  def gravatar(size = 'large')
    email_address = self.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    if size == 'small'
      image_src = "http://www.gravatar.com/avatar/#{hash}?s=34"
    else
      image_src = "http://www.gravatar.com/avatar/#{hash}?s=130"
    end
  end

  def calendar
    (0..34).map do |i|
      (Date.today + i.days).day
    end
  end
  
  protected
    def password_required?
     !persisted? || password.present? || password_confirmation.present?
   end
end
