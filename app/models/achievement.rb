class Achievement
  include Mongoid::Document

  # Fields
  field :name, type: String
  field :value, type: Integer
  field :badge, type: String
  field :category, type: String

  # Associations
  belongs_to :user

  TYPES = {
    good_roomie:        { value: 25, badge: "badges/roomie_good.png", category: "General" },
    great_roomie:       { value: 50, badge: "badges/roomie_great.png", category: "General" },
    awesome_roomie:     { value: 100, badge: "badges/roomie_awesome.png", category: "General" },
    best_roomie:        { value: 200, badge: "badges/roomie_best.png", category: "General" },
    impossible_roomie:  { value: 9999, badge: "badges/roomie_best.png", category: "General" }
  }

  attr_accessible :name, :value, :badge, :category
  
  def type
    TYPES.select { |k,v| k == self.name.to_sym }.values.first
  end
end
