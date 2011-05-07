class Achievement
  include Mongoid::Document

  # Fields
  field :name, :type => String
  field :value, :type => Integer
  field :badge, :type => String

  # Associations
  belongs_to :user

  TYPE = {
    :nice_roomie => { value: 25, badge: "badges/nice_roomie.png" },
    :cool_roomie => { value: 50, badge: "badges/cool_roomie.png" },
    :good_roomie => { value: 100, badge: "badges/good_roomie.png" },
    :super_roomie => { value: 200, badge: "badges/super_roomie.png" },
    :great_roomie => { value: 400, badge: "badges/great_roomie.png" },
    :fantastic_roomie => { value: 800 , badge: "badges/fantastic_roomie.png" },
    :amazing_roomie => { value: 1600, badge: "badges/amazing_roomie.png" }
  }
  
end
