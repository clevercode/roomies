class Assignment
  include Mongoid::Document

  field :purpose, :type => String
  field :value, :type => Integer

  include Trait::Completable
  include Trait::Validatable

  belongs_to :house
  belongs_to :category
end
