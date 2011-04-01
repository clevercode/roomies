module Trait
  # belongs to a commissioner that created an assignment
  # but may not be the assignee
  module Validatable
    extend ActiveSupport::Concern

    included do
      field :validated_at, :type => DateTime
      belongs_to :validator, :class_name => "User"
    end
  end
end
