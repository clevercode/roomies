class Assignment
  # basic model for assignements to be
  # inherited by more specific models
  include Mongoid::Document
  include Mongoid::Timestamps

  field :purpose, :type => String
  field :value, :type => Integer

  include Trait::Completable
  include Trait::Validatable

  belongs_to :house
  belongs_to :category

  validates :purpose, :presence => true

  # Returns an instance of the specified class with the attributes
  # and errors of the current document.
  #
  # @example Return a subclass document as a superclass instance.
  #   manager.becomes(Person)
  #
  # @raise [ ArgumentError ] If the class doesn't include Mongoid::Document
  #
  # @param [ Class ] klass The class to become.
  #
  # @return [ Document ] An instance of the specified class.
  def becomes(klass)
    unless klass.include?(Mongoid::Document)
      raise ArgumentError, 'A class which includes Mongoid::Document is expected'
    end
    became = klass.new
    became.instance_variable_set('@attributes', @attributes)
    became.instance_variable_set('@errors', @errors)
    became.instance_variable_set('@new_record', new_record?)
    became.instance_variable_set('@destroyed', destroyed?)
    became
  end
  

end
