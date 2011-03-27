class Authentication
  include Mongoid::Document

  # Fields
  field :user_id, :type => Integer
  field :provider, :type => String
  field :uid, :type => String

  # Associations
  belongs_to :user
end
