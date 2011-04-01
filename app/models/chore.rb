class Chore < Tasc

  # differs from a task because it is repeatable
  include Trait::Repeatable
end
