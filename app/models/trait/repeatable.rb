module Trait
  module Repeatable
    extend ActiveSupport::Concern

    included do
      field :frequency, :type => Integer
    end
  end
end

