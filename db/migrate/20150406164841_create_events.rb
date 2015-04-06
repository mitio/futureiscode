class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :speaker, null: false
      t.references :school, null: false
      t.date :date, null: false
      t.boolean :approved, null: false, default: false
      t.string :name
      t.text :details

      t.timestamps null: false
    end

    add_attachment :events, :cover_image

    add_index :events, [:approved, :date]
    add_index :events, :date
  end
end
