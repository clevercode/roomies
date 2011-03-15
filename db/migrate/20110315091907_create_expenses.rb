class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.string :purpose
      t.float :cost
      t.datetime :due_date
      t.boolean :recurring

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
