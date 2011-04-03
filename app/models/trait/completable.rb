module Trait
  module Completable
    extend ActiveSupport::Concern

    included do
      field :completed_at, :type => DateTime

      # stores one and only one house_id 
      belongs_to :house, :dependent => :delete
      # stores one and only one category_id
      belongs_to :category
    end
  end
end
