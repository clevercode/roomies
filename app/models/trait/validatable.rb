module Trait
  # belongs to a commissioner that created an assignment
  # but may not be the assignee
  module Validatable
    extend ActiveSupport::Concern

    included do
      belongs_to :validator
    end
  end
end
