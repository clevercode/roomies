class AddHouseIdToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :house_id, :integer
  end

  def self.down
    remove_column :expenses, :house_id
  end
end
