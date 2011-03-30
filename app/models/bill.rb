class Bill < Expense

  # differs from an expense because it is repeatable
  include Trait::Repeatable
end
