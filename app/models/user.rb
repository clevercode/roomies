class User 
  include Mongoid::Document

  # has_many :chores
  # has_many :expenses
  # has_one :house
  references_many :authentications, :dependent => :delete

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  field :name

  validates :name,  :presence => true
  validates :email, :presence => true,
                    :uniqueness => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def apply_omniauth(omniauth)
    user_info = omniauth['user_info']
    if omniauth['extra'] && omniauth['extra']['user_hash']
      user_info.merge!(omniauth['extra']['user_hash'])
    end

    if self.name.blank?
      self.name   = user_info['name'] unless user_info['name'].blank?
      self.name ||= user_info['nickname'] unless user_info['nickname'].blank?
      self.name ||= (user_info['first_name']+" "+user_info['last_name']) unless \
        user_info['first_name'].blank? || user_info['last_name'].blank?
    end

    if self.email.blank?
      self.email = user_info['email'] unless user_info['email'].blank?
    end

    self.password, self.password_confirmation = String::RandomString(16)  
    self.confirmed_at, self.confirmation_sent_at = Time.now
  end

  def to_s
    self.name || self.email
  end
end
