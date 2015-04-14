class AddIndexOnSchoolsUpdatedAt < ActiveRecord::Migration
  def change
    add_index :schools, :updated_at
  end
end
