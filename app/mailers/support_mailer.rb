class SupportMailer < ActionMailer::Base

  default :from => "roomies@clevercode.net"

  include ActionView::Helpers::TextHelper 
  
  def submit_request(support_request)
    @support_request = support_request
    mail(:to       => 'roomies@clevercode.net',
         :reply_to => @support_request.reply_to,
         :subject  => "Roomies support: " + truncate(@support_request.message, :length => 25, :omission => ' (...)'),
    )
  end
end
