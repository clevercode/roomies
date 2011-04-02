class Wish < Bounty
  # a wish is a bounty with an associated cost
  # since it requires the purchase of an item,
  # its commissioner should define a value
  include Trait::Payable # cost [float]
end
