class AddIndexOnSchoolsConfirmationToken < ActiveRecord::Migration
  def change
    add_index :schools, :confirmation_token, unique: true
  end
end
