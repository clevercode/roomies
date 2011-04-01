module Trait
  # belongs to a commissioner that created an assignment
  # but may not be the assignee
  module Commissionable
    extend ActiveSupport::Concern

    included do
      belongs_to :commissioner, :class_name => "User"
    end
  end
end
