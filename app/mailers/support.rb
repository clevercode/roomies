class Support < ActionMailer::Base
  default :from => "support@roomiesapp.com"
  
  def submit_request(params)
    mail(:to      => 'zacharynicoll@gmail.com',
         :from    => 'support@roomiesapp.com',
         :subject => params[:request][:message].split[0..7].join(' '),
         :title   => "A message from #{params[:request][:name]}:",
         :email   => params[:request][:email],
         :message => params[:request][:message]
    )
  end
end