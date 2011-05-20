class User 
  include Mongoid::Document
  include Mongoid::Timestamps

  require 'digest/md5'
  require 'open-uri'
  require 'json'
  
  # after_create :send_welcome_email
  before_create :set_invitation_limit

  # Fields
  field :name, :type => String
  field :points, :type => Integer
  field :locale, :type => String, :default => "en"
  field :calendar, :type => String, :default => "centric"
  field :secret, :type => String

  # Associations
  belongs_to :house # => User has a house_id
  has_many :authentications, :dependent => :delete
  has_many :assignments, :foreign_key => 'assignee_ids'
  has_many :rewards
  has_many :achievements

  # Devise
  devise  :database_authenticatable, :registerable, :recoverable, 
          :rememberable, :trackable, :validatable, :invitable

  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false }

  validates :invitation_token, :presence => true, :on => :create

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :remember_me, :locale, :calendar

  ###
  # user methods
  ###
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    # Check if email is already into the database => user exists
    apply_trusted_services(omniauth) if self.new_record?
  end
  
  # Create a new user
  def apply_trusted_services(omniauth)  
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
      # if user_info['email'].present?
      #   self.email = user_info['email'] unless user_info['email'].blank?
      # else
      #   self.email = "#{Time.now.to_i}#{rand(777)}@roomieapp.com"
      # end
    end  

    # Set a random password for omniauthenticated users
    self.password, self.password_confirmation = String::RandomString(16)

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
      image_src = "http://www.gravatar.com/avatar/#{hash}?s=41"
    else
      image_src = "http://www.gravatar.com/avatar/#{hash}?s=130"
    end
  end
  
  def house_invitation
    @house_invitation = HouseInvitation.where(:email => self.email).first
    unless @house_invitation.nil?
      @house_invitation
    else
      nil
    end
  end
  

  def check_for_achievements
    if self.points > 50
      self.achievements.create(name: "Megatop Roomie")
      if self.points < stuff && self.points > stuff
        Achievement.create(user_id: self.id, )
      end
    end
  end

  def check_payment
    if self.secret
      url = "http://www.pintpay.com/api/1/subscriptions"
      result = JSON.parse(
        open("#{url}/#{self.secret}?api_key=#{ENV['PINTPAY_API_KEY']}&api_secret=#{ENV['PINTPAY_API_SECRET']}").read
      )
    end
  end

  private
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def set_invitation_limit
    self.invitation_limit = 3
  end
  
  protected
  def password_required?
   !persisted? || password.present? || password_confirmation.present?
  end
end
