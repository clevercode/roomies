class Freebie < Assignment
  # a freebie is a voluntary action that benefits
  # the household and for which the commissioner
  # may claim points to be defined by the validator
  #
  # NB: this might be too similar to bounty
  belongs_to :claimant, :class_name => 'User'
  field :claimed_at, :type => DateTime
end
