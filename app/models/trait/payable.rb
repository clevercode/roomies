module Trait
  module Payable
    extend ActiveSupport::Concern

    included do
      field :cost, :type => Float
      field :payed_at, :type => DateTime
    end
  end
end
