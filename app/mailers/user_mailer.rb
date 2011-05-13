class UserMailer < ActionMailer::Base
  default :from => "notifications@roomiesapp.com"
  
  def welcome_email(params)
    mail(:to      => params[:email],
         :subject => "Welcome to Roomies!",
    )
  end

  def invitation_email(params)
    mail(:to      => params[:email],
         :subject => "You have a new invitation from a friend at Roomies!",
    )
  end

  def beta_invite(invite, url)
    @invite = invite
    @url = url
    mail(
      :to      => invite.recipient_email,
      :subject => "Hey look, a Roomies beta invite!",
    )
    invite.update_attributes(sent_at: Time.now)
  end
end
