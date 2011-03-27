class House
  include Mongoid::Document
  
  # Fields
  field :name, :type => String

  # Associations
  has_many :users
    
end
