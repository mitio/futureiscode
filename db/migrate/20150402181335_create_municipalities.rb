class CreateMunicipalities < ActiveRecord::Migration
  def change
    create_table :municipalities do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.integer :state_id, null: false

      t.timestamps null: false
    end
    add_index :municipalities, :code, unique: true
    add_index :municipalities, :state_id
  end
end
