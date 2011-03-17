class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :house

  validates :user_id, :presence => true
end
