class CreateHouses < ActiveRecord::Migration
  def self.up
    create_table :houses do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :houses
  end
end
