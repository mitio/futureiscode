class AddEventsCountToSchools < ActiveRecord::Migration
  def up
    add_column :schools, :events_count, :integer, null: false, default: 0
    execute 'UPDATE schools SET events_count = (SELECT COUNT(*) FROM events WHERE school_id = schools.id)'
  end

  def down
    remove_column :schools, :events_count
  end
end
