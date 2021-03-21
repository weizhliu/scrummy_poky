class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :uuid
      t.bigint :last_room

      t.index :uuid
      t.timestamps
    end
  end
end
