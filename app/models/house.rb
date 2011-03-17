# == Schema Information
# Schema version: 20110317062640
#
# Table name: houses
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class House < ActiveRecord::Base
  has_many :users, :through => :tasks
  has_many :chores
  has_many :expenses
end
