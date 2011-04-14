class Support < ActionMailer::Base
  default :from => "support@roomiesapp.com"
  
  def submit_request(params)
    request = params[:request]
    mail(:to       => 'contact@clevercode.net',
         :reply_to => request[:email],
         :subject  => request[:message].split[0..7].join(' '),
         :title    => "A message from #{request[:name]}:",
         :email    => request[:email]
    ) do |format|
      format.text { render :text  => "#{request[:message]}" }
      format.html { render :text  => "<h1>Hey there, you sexy beast!</h1>" +
                                     "<h3>It seems you've gotten a new message from a loyal follower at roomies. Yay for you!</h3>" +
                                     "===================================" +
                                     "<p>#{request[:message]}</p>"
      }
    end
  end
end