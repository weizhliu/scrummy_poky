class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :base
      t.integer :status

      t.index :base
      t.timestamps
    end
  end
end
