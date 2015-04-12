class AddLatitudeAndLongitudeToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :latitude, :float
    add_column :schools, :longitude, :float
  end
end
