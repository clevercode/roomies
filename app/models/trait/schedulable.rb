module Trait
  module Schedulable
    extend ActiveSupport::Concern

    included do
      field :due_date
    end
  end
end
