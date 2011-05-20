class Support < ActionMailer::Base

  default :from => "roomies@clevercode.net"

  include ActionView::Helpers::TextHelper 
  
  def submit_request(params)
    @request = params[:request]
    mail(:to       => 'roomies@clevercode.net',
         :reply_to => @request[:email],
         :subject  => "Roomies support: " + truncate(@request[:message], :length => 25, :omission => ' (...)'),
         :email    => @request[:email]
    )
  end
end
