module Trait
  module Payable
    extend ActiveSupport::Concern

    included do
      field :cost, :type => Float
    end
  end
end
