class Assignment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :purpose, :type => String
  field :due_date, :type => Date
  field :frequency, :type => Integer
  field :cost, :type => Float  

  field :refused_at, :type => DateTime
  field :completed_at, :type => DateTime
  field :validated_at, :type => DateTime

  # can be added on completion or refusal
  field :comments, :type => String
  
  # added on create & updated
  field :type, :type => String

  # achievement
  field :value, :type => Integer

  scope :due, where(:completed_at.ne => nil).and(:due_date.gte => Date.today)
  scope :past_due, where(completed_at: nil).and(:due_date.lt => Date.today )

  belongs_to :house, :dependent => :delete
  belongs_to :category

  has_and_belongs_to_many :assignees, :stored_as => :array, :class_name => "User"
  belongs_to :commissioner, :class_name => "User"
  belongs_to :validator, :class_name => "User"

  validates :purpose, :presence => true
  
  before_save do
    if self.cost.blank?
      self.type = "task"
    else
      self.type = "expense"
    end
  end

end
