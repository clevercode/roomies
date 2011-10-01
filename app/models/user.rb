require 'digest/md5'
require 'open-uri'

class User 
  include Mongoid::Document
  include Mongoid::Timestamps

  after_create :send_welcome_email
  before_create :set_invitation_limit
  before_save :update_stripe

  # Fields
  field :name, type: String
  field :points, type: Integer, default: 0
  field :locale, type: String, default: "en"
  field :calendar, type: String, default: "centric"
  field :secret, type: String
  field :time_zone, type: String
  field :stripe_id, type: String
  field :last_4_digits, type: String
  attr_accessor :stripe_token # Secure card token
  
  # Associations
  belongs_to :house # => User has a house_id
  has_many :authentications, dependent: :delete
  has_many :assignments, foreign_key: 'assignee_ids'
  has_many :rewards
  has_many :achievements

  # Indexes
  index :email, unique: true

  # Devise
  devise  :database_authenticatable, :registerable, :recoverable, 
          :rememberable, :trackable, :validatable, :invitable

  validates :email, 
            presence: true,
            uniqueness: { case_sensitive: false }

  # validates_presence_of :invitation_token, 
  #                       on: :create, 
  #                       message: "misssing, signing up for now."

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :remember_me, :locale, :calendar, :stripe_token

  ###
  # user methods
  ###
  
  def apply_omniauth(omniauth)
    omniauth['user_info']['email']
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
    # retrieving the achievements the user ought to have in an array
    oughts = []

    Achievement::TYPES.each_pair do |key, values|
      if values[:value] <= self.points
        oughts << key
      end
    end

    # only checking what achievements the user has if he oughts
    # to have any new ones
    if oughts.length > 0
      # retrieving the achievements the user already has
      has = []
      # if the user has achievements, let's make sure we only add new ones
      has = self.achievements.map(&:name)
      has = has.map(&:to_sym)

      new = oughts - has
      # iterating over the array of new achievements to create them on the user
      new.each do |n|
        a = Achievement::TYPES[n]
        self.achievements.create(:name => n)
      end
    end
  end

  def next_achievement
    Achievement::TYPES.select { |k,v| v[:value] >= self.points }
  end

  def billing
    Stripe::Customer.retrieve(stripe_id) if stripe_id
  end

  private
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def set_invitation_limit
    self.invitation_limit = 3
  end

  def update_stripe
    if stripe_token
      if stripe_id.present?
        stripe_customer = Stripe::Customer.retrieve(stripe_token)
        stripe_customer.card = stripe_token
        stripe_customer.save
      else
        stripe_customer = Stripe::Customer.create(
          description: email,
          card: stripe_token
        )
        self[:stripe_id] = stripe_customer.id
      end
      self.last_4_digits = stripe_customer.active_card.last4

    else
    end
  end
  
  protected
  def password_required?
   !persisted? || password.present? || password_confirmation.present?
  end
end
