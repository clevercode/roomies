class Tasc < Assignment
  
  include Trait::Assignable # assignees
  include Trait::Commissionable # comissioner
  include Trait::Schedulable # due_at [datetime]
end
