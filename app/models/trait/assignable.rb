module Trait
  # can be assigned to one or more assignees
  module Assignable
    extend ActiveSupport::Concern
    
    included do
      # has access to an array of Assignees that have its id for assignable_id
      # also stores the references to every assignees on the Assignable module itself
      has_and_belongs_to_many :assignees, :stored_as => :array, :class_name => "User"
    end
  end
end
