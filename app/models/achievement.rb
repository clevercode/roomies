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
    nice_roomie:      { value: 25, badge: "badges/roomie_nice.png", category: "General" },
    cool_roomie:      { value: 50, badge: "badges/roomie_cool.png", category: "General" },
    good_roomie:      { value: 100, badge: "badges/roomie_good.png", category: "General" },
    super_roomie:     { value: 200, badge: "badges/roomie_super.png", category: "General" },
    great_roomie:     { value: 400, badge: "badges/roomie_great.png", category: "General" },
    fantastic_roomie: { value: 800 , badge: "badges/roomie_fantastic", category: "General" },
    amazing_roomie:   { value: 1600, badge: "badges/roomie_amazing", category: "General" }
  }

  attr_accessible :name, :value, :badge, :category
  
  def type
    TYPES.select { |k,v| k == self.name.to_sym }.values.first
  end
end
