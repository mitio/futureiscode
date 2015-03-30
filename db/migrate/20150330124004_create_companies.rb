class CreateCompanies < ActiveRecord::Migration
  def up
    create_table :companies do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :url
      t.boolean :pledged_support, null: false, default: false

      t.timestamps null: false
    end

    add_attachment :companies, :logo
    add_index :companies, :name, unique: true
    add_index :companies, :slug, unique: true
  end

  def down
    drop_table :companies
  end
end
