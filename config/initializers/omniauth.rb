# require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, '6L5zgyu7vznSUPQQkyWEqg', 'pyod6U46aColNjQ2tni5y7tOF6BVIsXPh3hTow' 
  provider :facebook, '143753272357200', '1a49da80193a3c81e1bc01b43837830e'

  # provider :openid, OpenID::Store::Filesystem.new('/tmp')
  # use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => 'yahoo', :identifier => 'yahoo.com'
  # use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'  
end  

