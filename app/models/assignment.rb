class Assignment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :purpose,         :type => String
  field :due_date,        :type => Date
  field :duration,        :type => Integer
  field :duration_length, :type => String
  field :duration_stop,   :type => Date
  field :cost,            :type => Float  
  field :refused_at,      :type => DateTime
  field :completed_at,    :type => DateTime
  field :validated_at,    :type => DateTime
  field :assignee_names,  :type => String

  # can be added on completion or refusal
  field :comments,        :type => String
  
  # added on create & updated
  field :type,            :type => String

  # achievement
  field :value,           :type => Integer

  scope :due, where(completed_at: nil).and(:due_date.gte => Date.today).asc(:due_date)
  scope :past_due, where(completed_at: nil).and(:due_date.lt => Date.today ).asc(:due_date)
  scope :completed, where(:completed_at.ne => nil).desc(:completed_at)
  scope :house, ->(house) { where(house_id: house.id) }

  has_and_belongs_to_many :assignees, :class_name => "User"

  # has_and_belongs_to_many :assignees, :stored_as => :array, :class_name => "User"
  belongs_to :commissioner, class_name: "User"
  belongs_to :completor,    class_name: "User"
  belongs_to :validator,    class_name: "User"
  belongs_to :house  
  belongs_to :category

  validates  :purpose,        presence: true

  before_save do
    if self.cost.blank?
      self.type = "task"
    else
      self.type = "expense"
    end
  end

end
