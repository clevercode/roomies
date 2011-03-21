class User 
  include Mongoid::Document

  # has_many :chores
  # has_many :expenses
  # has_one :house
  embeds_many :authentications

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  field :name

  validates :name, :presence => true
  validates :email, :presence => true,
                    :uniqueness => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def to_s
    self.email
  end
end
