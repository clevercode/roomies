module ActionMailerHelpers
  def ignore_mailers
    ActionMailer::Base.any_instance.stub(:deliver).and_return true
    result = yield
    ActionMailer::Base.any_instance.unstub(:deliver)
    return result
  end
end


RSpec.configure do |config|
  config.include ActionMailerHelpers
  config.include Shoulda::Matchers::ActionMailer
end

