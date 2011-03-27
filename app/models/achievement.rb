class Achievement
  include Mongoid::Document

  # Fields
  field :name, :type => String
  field :value, :type => Integer
  field :badge, :type => String

  # Associations
  has_one :user
  
end
