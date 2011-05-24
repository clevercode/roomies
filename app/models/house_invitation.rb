class HouseInvitation
  include Mongoid::Document
  
  after_create :send_house_invitation_email
  
  # Fields
  field :email
  field :house_inviter_id

  private
  def send_house_invitation_email
    UserMailer.house_invitation_email(self).deliver
  end
  
end
