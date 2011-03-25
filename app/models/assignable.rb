class Assignable
  include Mongoid::Document

  field :purpose, :type => String
  field :due_date, :type => DateTime
  field :recurring, :type => Boolean

  references_many :assignees
  references_one :house, :dependent => :delete
end
