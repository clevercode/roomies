class AddUserIdToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :user_id, :integer
  end

  def self.down
    remove_column :expenses, :user_id
  end
end
