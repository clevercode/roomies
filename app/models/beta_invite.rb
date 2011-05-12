class BetaInvite
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :recipient_email, :type => String
  field :token, :type => String

  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'

  validates :recipient_email, :presence => true,
                              :uniqueness => true,
                              :format => { 
                                :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                                :on => :create 
                              }
  validate :sender_has_invites, :if => :sender
  validate :recipient_not_registered
  private
  def sender_has_invites
    unless sender.beta_invite_limit > 0
      errors.add_to_base t('.beta_invite_limit_reached')
    end
  end
  def recipient_not_registered
    errors.add :recipient_email, 'is already signed up' if User.where(email: recipient_email).first
  end
  
end
