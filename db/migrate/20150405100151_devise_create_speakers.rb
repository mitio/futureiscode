class DeviseCreateSpeakers < ActiveRecord::Migration
  def change
    create_table(:speakers) do |t|
      t.string :name, null: false
      t.references :company
      t.string :other_company
      t.string :phone

      # Devise fields
      # - Database authenticatable
      t.string :email,              null: false
      t.string :encrypted_password, null: false
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

      t.timestamps null: false
    end

    add_index :speakers, :email,                unique: true
    add_index :speakers, :reset_password_token, unique: true
    add_index :speakers, :confirmation_token,   unique: true
  end
end
