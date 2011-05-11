class BetaInvite
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :sender_id, :type => String
  field :recipient_email, :type => String
  field :token, :type => String

  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'
end