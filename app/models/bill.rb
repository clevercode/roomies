class Bill < Expense
  # a bill is a repeatable expense
  include Trait::Repeatable # frequency [integer]
end
