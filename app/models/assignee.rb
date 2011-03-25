class Assignee
  include Mongoid::Document
  field :user_id, :type => Integer
  references_one :user
  referenced_in :assignable
end
