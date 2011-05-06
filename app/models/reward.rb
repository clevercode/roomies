class Reward
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :type, :type => Symbol, :default => :random
  field :points, :type => Integer, :default => 1

  belongs_to :user

  TYPES = {
    :random => { :points => 0 },
    :sign_in => { :points => 1 },
    :assignment => { :points => 2 },
    :completion => { :points => 3 },
    :validation => { :points => 1 }
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
    self.user.inc(:points_count, self.points)

    self.user.check_for_achievements
  end

end
