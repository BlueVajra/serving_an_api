class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :make_id
      t.string :color
      t.integer :doors
      t.date :purchased_on
      t.timestamps
    end
  end
end
