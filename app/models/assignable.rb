class Assignable
  include Mongoid::Document

  # Fields
  field :purpose, :type => String
  field :due_date, :type => DateTime
  field :recurring, :type => Boolean

  # Associations
  belongs_to :house, :dependent => :delete # stores one and only one house_id
  # has_many :assignees
  has_and_belongs_to_many :assignees, :stored_as => :array # has access to an array of Assignees that have its id for assignable_id
  # also stores the references to every assignees on the Assignable model itself
  belongs_to :category
  # stores one and only one category_id
end
