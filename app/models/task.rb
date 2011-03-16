class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :house
end
