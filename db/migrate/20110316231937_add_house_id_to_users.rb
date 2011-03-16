class AddHouseIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :house_id, :integer
  end

  def self.down
    remove_column :users, :house_id
  end
end
