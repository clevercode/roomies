class House
  include Mongoid::Document
  
  # Fields
  field :name, type: String
  
  validates :name, presence: true
  
  attr_accessible :name

  # Associations
  has_many :users
  has_many :assignments
  belongs_to :sponsor, class_name: "User"

  # Callbacks
  before_save :update_sponsor_subscription

  def sponsored?
    sponsor.present? # && !failed_to_bill?
  end

  private

  def update_sponsor_subscription
    if sponsor_id_changed?
      if sponsor_id_was
        User.find(sponsor_id_was).billing.cancel_subscription
      end
      if sponsor
        sponsor.billing.update_subscription(plan: 'basic')
      end
    end
  end

end
