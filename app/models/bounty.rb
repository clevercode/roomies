class Bounty < Assignment
  # a bounty can be commissioned with no assignee
  # for a non-urgent task, its value should be 
  # defined by the commissioner
  include Trait::Commissionable
end
