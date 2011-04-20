class UserMailer < ActionMailer::Base
  default :from => "notifications@roomiesapp.com"
  
  def welcome_email(params)
    mail(:to      => params[:email],
         :subject => "Welcome to Roomies!",
    ) do |format|
      format.text { render :text  => "You should have html emails enabled dummy." }
      format.html { render :text  => "<h1>Hey there, you sexy beast!</h1>" +
                                    "===================================" +
                                    "<p>You have successfully signed up to roomie and we love you.</p>" +
                                    "<p>Thanks for joining and have a great day!</p>"
      }
    end
  end
end