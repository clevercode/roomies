class House
  include Mongoid::Document
  
  # Fields
  field :name, :type => String

  # Associations
  references_many :users, :dependent => :delete
  referenced_in :assignable
end
