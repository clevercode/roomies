class Assignee
  include Mongoid::Document

  # Fields
  field :cut, :type => Integer
  
  # Associations
  references_one :user
  referenced_in :assignable
end
