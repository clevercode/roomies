class House
  include Mongoid::Document
  
  # Fields
  field :name, :type => String
  
  validates :name, :presence => true
  
  attr_accessible :name

  # Associations
  has_many :users # has access to an array of Users that have its id for house_id
  has_many :expenses, :through => :users
  has_many :tascs,    :through => :users
  has_many :bills,    :through => :users
  has_many :chores,   :through => :users
  has_many :freebies, :through => :users
  has_many :bounties, :through => :users
end
