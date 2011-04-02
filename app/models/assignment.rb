class Assignment
  include Mongoid::Document

  field :value, :type => Integer
  
  belongs_to :house
  belongs_to :category
end
