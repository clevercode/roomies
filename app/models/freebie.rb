class Freebie < Assignment
  # a freebie is a voluntary action that benefits
  # the household and for which the commissioner
  # may claim points to be defined by the validator
  #
  # NB: this might be too similar to bounty
  include Trait::Commissionable
end
