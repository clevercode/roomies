class Authentication
  include Mongoid::Document

  embeds_one :user

  field :user_id, :type => Integer
  field :provider, :type => String
  field :uid, :type => String
end
