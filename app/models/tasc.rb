class Tasc < Assignment
  # a task is a basic assignment with assignees,
  # a commissioner and a due date 
  include Trait::Assignable # assignees
  include Trait::Commissionable # comissioner
  include Trait::Schedulable # due_at [datetime]
end
