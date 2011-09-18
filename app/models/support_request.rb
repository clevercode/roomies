class SupportRequest

  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Translation
  extend ActiveModel::Callbacks
    
  attr_accessor :name, :email, :message
    
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :message
  
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  define_model_callbacks :save
  
  def initialize(attributes={})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def read_attribute_for_validation(key)
    send(key)
  end

  def reply_to
    "#{name} <#{email}>"
  end
  
  def persisted?
    false
  end
  
  def save
    if valid?
      SupportMailer.submit_request(self).deliver
    else
      return false
    end
  end
end
