class AddHouseIdToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :house_id, :integer
  end

  def self.down
    remove_column :tasks, :house_id
  end
end
