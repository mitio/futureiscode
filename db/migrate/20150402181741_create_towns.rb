class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :kind, null: false
      t.string :code, null: false
      t.string :name, null: false
      t.integer :municipality_id, null: false

      t.timestamps null: false
    end
    add_index :towns, :code, unique: true
    add_index :towns, :municipality_id
  end
end
