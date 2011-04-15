class Gift < Freebie
  # a gift is a voluntary action that benefits the 
  # household, has a cost, and for which the commissioner
  # may claim points to be defined by the validator
  include Trait::Payable # cost [float]
end

