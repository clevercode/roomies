class House
  include Mongoid::Document
  
  # Fields
  field :name, :type => String
  
  validates :name, :presence => true
  
  attr_accessible :name

  # Associations
  has_many :users
  has_many :assignments
end
