class Expense < Assignable
  include Mongoid::Document
  
  # Fields
  field :cost, :type => Float
end

