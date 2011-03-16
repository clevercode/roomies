class House < ActiveRecord::Base
  has_many :users, :through => :tasks
  has_many :tasks
  has_many :expenses
end
