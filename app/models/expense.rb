class Expense < Tasc
  # An expense is a task with an associated cost
  include Trait::Payable # cost [float]
end

