class UserMailer < ActionMailer::Base
  default :from => "notifications@roomiesapp.com"
  
  def welcome_email(params)
    params[:email].downcase!
    mail(:to      => params[:email],
         :subject => "Welcome to Roomies!"
    )
  end

  def house_invitation_email(params)
    params[:email].downcase!
    @invite = params[:_id]
    mail(:to      => params[:email],
         :subject => "You have a new house invitation from a friend at Roomies!"
    )
  end

  def beta_invite(invite, url)
    @invite = invite
    @url = url
    mail(
      :to      => invite.recipient_email,
      :subject => "Hey look, a Roomies beta invite!"
    )
    invite.update_attributes(sent_at: Time.now)
  end

  def assignment_created(assignment, recipients, url)
    @assignment = assignment
    @url = url
    @recipients = recipients
    mail(
      :to => @recipients,
      :subject => "Stuff to do from a Roomie"
    )
  end
end
