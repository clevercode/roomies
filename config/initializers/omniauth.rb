# require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  provider :facebook, ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_API_KEY']

  # provider :openid, OpenID::Store::Filesystem.new('/tmp')
  # use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => 'yahoo', :identifier => 'yahoo.com'
  # use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'  
end  

