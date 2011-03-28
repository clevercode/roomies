class House
  include Mongoid::Document
  
  # Fields
  field :name, :type => String

  # Associations
  has_many :users # has access to an array of Users that have its id for house_id
    
end
