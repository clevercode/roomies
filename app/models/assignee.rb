class Assignee
  include Mongoid::Document

  # Fields
  field :cut, :type => Integer
  
  # Associations
  belongs_to :user # has only one user_id
  belongs_to :assignable # has only one assignable_id
end
