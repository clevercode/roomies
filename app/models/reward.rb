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

end
