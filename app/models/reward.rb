class Reward
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :type,        :type => Symbol,  :default => :random
  field :points,      :type => Integer, :default => 1
  field :past_reward, :type => Boolean, :default => false

  belongs_to :user

  TYPES = {
    :random => { :points => 0 },
    :sign_in => { :points => 1 },
    :assignment => { :points => 2 },
    :assignments_create_lazy => { :points => 1 },
    :assignments_create_lonely => { :points => 2 },
    :assignments_create_sharing => { :points => 3 },
    :assignments_complete => { :points => 3 },
    :assignments_undo_complete => { :points => -3 },
    :assignments_confirm => { :points => 1 },
    :assignments_reject => { :points => -3 },
    :house_invitations_create => { :points => 1 }
  }

  before_save do
    begin

    if self.points.blank? && !self.type.blank?
      self.points = TYPES[self.type][:points]
    end

    rescue(NoMethodError)
      raise("This type of reward - [:#{self.type}] - doesn't exist. Check the Reward model.")

    end
  end

  after_create do
    self.user.inc(:points, self.points)

    self.user.check_for_achievements
  end

end
