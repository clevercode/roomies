class Invitation
  include Mongoid::Document
  
  after_create :send_invitation_email
  
  # Fields
  field :email
  # field :inviter_id

  belongs_to :inviter, :class_name => "User"

  private
  def send_invitation_email
    UserMailer.invitation_email(self).deliver
  end
  
end
