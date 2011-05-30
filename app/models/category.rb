class Category
  include Mongoid::Document

  # Fields
  field :name, :type => String

  # Associations
  has_many :assignables

  TYPES = {
    :general => { :points => 2 },
    :kitchen => { :points => 3},
    :groceries => { :points => 4 },
    :garden => { :points => 5 },
    :bills => { :points => 6 }
  }

  def category_name
    category.name if category
  end

  def category_name=(name)
    self.category = Category.find_or_create_by(name) unless name.blank?
  end

end
