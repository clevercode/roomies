class Assignable
  include Mongoid::Document

  # Fields
  field :purpose, :type => String
  field :due_date, :type => DateTime
  field :recurring, :type => Boolean

  # Associations
  belongs_to :house, :dependent => :delete
  # has_many :assignees
  has_and_belongs_to_many :assignees, :stored_as => :array
  belongs_to :category
end
