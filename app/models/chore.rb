class Chore < Tasc
  # A chore is a repetitive task
  include Trait::Repeatable # frequency [integer]
end
