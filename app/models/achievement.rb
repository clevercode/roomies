# == Schema Information
# Schema version: 20110317062640
#
# Table name: achievements
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  value      :integer
#  badge      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Achievement  
  # belongs_to :user
end
