class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name, null: false
      t.integer :town_id, null: false
      t.string :address, null: false
      t.string :contact_name, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :phone
      t.boolean :confirmed_participation

      # Devise fields
      # - Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      # - Rememberable
      t.datetime :remember_created_at
      # - Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      # - Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      t.text :dates
      t.text :details
      t.text :notes

      t.timestamps null: false
    end

    add_index :schools, :email, unique: true
    add_index :schools, :reset_password_token, unique: true
    add_index :schools, [:confirmed_participation, :name]
  end
end
