class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :purpose
      t.datetime :due_date
      t.boolean :recurring

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
