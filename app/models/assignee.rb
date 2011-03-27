class Assignee
  include Mongoid::Document

  # Fields
  field :cut, :type => Integer
  
  # Associations
  belongs_to :user
  belongs_to :assignable
end
