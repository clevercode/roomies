class UserMailer < ActionMailer::Base
  default :from => "notifications@roomiesapp.com"
  
  def welcome_email(params)
    mail(:to      => params[:email],
         :subject => "Welcome to Roomies!",
    ) do |format|
      format.text { render :text  => "You should have html emails enabled dummy." }
      format.html { render :text  => "<h1>Hey there, you sexy beast!</h1>" +
                                    "===================================" +
                                    "<p>You have successfully signed up to Roomies and we" +
                                    "love you. Thanks for joining and have a great day!</p>"
      }
    end
  end

  def invitation_email(params)
    mail(:to      => params[:email],
         :subject => "You have a new invitation from a friend at Roomies!",
    ) do |format|
      format.text { render :text  => "You should have html emails enabled dummy." }
      format.html { render :text  => "<h1>Hey there, you sexy beast!</h1>" +
                                    "===================================" +
                                    "<p>Someone you live with(hopefully), sent you an " +
                                    "invitation to move into their house on Roomies!</p>" +
                                    "<p>If you already have an account, you can simple sign " +
                                    "in and accept the invitation. If you're new to the whole " +
                                    "thing, head over to roomiesapp.com and signup. As soon " +
                                    "as your logged in, you will see a notification staring you " +
                                    "in the face, asking you to accept or reject the invitation. " +
                                    "Have super fantabulous day!</p>"
      }
    end
  end
end