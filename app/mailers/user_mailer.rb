class UserMailer < ActionMailer::Base
  default :from => "notifications@roomiesapp.com"
  
  def welcome_email(params)
    mail(:to      => params[:email],
         :subject => "Welcome to Roomies!"
    )
  end

  def house_invitation_email(params)
    @recipient_email = params[:email]
    @inviter         = User.find(params[:house_inviter_id])
    @invite          = params[:_id]
    mail(:to      => @recipient_email,
         :subject => "You have a new Roomies house invitation from #{(@inviter.name.blank?) ? @inviter.email : @inviter.name}"
    )
  end

  def assignment_created(assignment, recipients, url)
    @assignment = assignment
    @url = url
    @recipients = recipients
    @commissioner = @assignment.commissioner
    mail(
      :to => @recipients,
      :subject => "Stuff to do from #{(@commissioner.name.blank?) ? @commissioner.email : @commissioner.name} on Roomies"
    )
  end
end
