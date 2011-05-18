class Support < ActionMailer::Base
  default :from => "support@roomiesapp.com"
  
  def submit_request(params)
    @request = params[:request]
    mail(:to       => 'contact@clevercode.net',
         :reply_to => @request[:email],
         :subject  => "Roomies support: " + truncate(@request[:message], :length => 10, :omission => ' (...)'),
         :email    => @request[:email]
    )
  end
end
