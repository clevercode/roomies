module Trait
  module Completable
    extend ActiveSupport::Concern

    included do
      field :completed, :type => Boolean

      # stores one and only one house_id 
      belongs_to :house, :dependent => :delete
      # stores one and only one category_id
      belongs_to :category
    end
  end
end
