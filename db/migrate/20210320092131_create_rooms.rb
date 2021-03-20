class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :base
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.index :base
      t.timestamps
    end
  end
end
