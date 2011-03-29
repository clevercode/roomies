module Trait
  module Schedulable
    extend ActiveSupport::Concern

    included do
      field :due_date, :type => DateTime
    end
  end
end
