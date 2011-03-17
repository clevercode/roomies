# == Schema Information
# Schema version: 20110317140030
#
# Table name: chores
#
#  id         :integer         not null, primary key
#  purpose    :string(255)
#  due_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  house_id   :integer
#

class Chore
  # include Mongoloid::Document
  
  # belongs_to :user
  # belongs_to :house

  # validates :user_id, :presence => true
end
