class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.string :purpose
      t.datetime :due_date
      t.float :cost

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
