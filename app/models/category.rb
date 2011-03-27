class Category
  include Mongoid::Document

  # Fields
  field :name, :type => String

  # Associations
  has_many :assignables

end
