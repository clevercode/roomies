class Category
  include Mongoid::Document

  # Fields
  field :name, :type => String

  # Associations
  has_many :assignables

  def category_name
    category.name if category
  end

  def category_name=(name)
    self.category = Category.find_or_create_by(name) unless name.blank?
  end

end
