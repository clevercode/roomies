# == Schema Information
# Schema version: 20110316231937
#
# Table name: expenses
#
#  id         :integer         not null, primary key
#  purpose    :string(255)
#  due_date   :datetime
#  cost       :float
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  house_id   :integer
#

class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :house

  validates :user_id, :presence => true
end