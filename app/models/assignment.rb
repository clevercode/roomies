class Assignment
  # basic model for assignements to be
  # inherited by more specific models
  include Mongoid::Document

  field :purpose, :type => String
  field :value, :type => Integer

  include Trait::Completable
  include Trait::Validatable

  belongs_to :house
  belongs_to :category

  validates :purpose, :presence => true

end
