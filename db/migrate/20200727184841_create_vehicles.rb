class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :colour
      t.integer :price
      t.string :make

      t.timestamps
    end
  end
end
