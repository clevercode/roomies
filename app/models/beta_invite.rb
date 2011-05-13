class BetaInvite
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :recipient_email, :type => String
  field :token, :type => String

  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'

  validates :recipient_email, :presence => true,
                              :uniqueness => true,
                              :format => { 
                                :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                                :on => :create 
                              }
  validate :sender_has_invites, :if => :sender
  validate :recipient_not_registered

  before_create :generate_token
  before_create :decrement_sender_count, :if => :sender

  private
  def sender_has_invites
    unless sender.beta_invite_limit > 0
      errors.add(:base, 'You have sent out all your invites for now.')
    end
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def decrement_sender_count
    sender.inc(:beta_invite_limit, -1)
  end

  def recipient_not_registered
    errors.add :recipient_email, 'is already signed up' if User.where(email: recipient_email).first
  end
  
end
