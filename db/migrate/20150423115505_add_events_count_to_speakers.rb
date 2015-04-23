class AddEventsCountToSpeakers < ActiveRecord::Migration
  def up
    add_column :speakers, :events_count, :integer, null: false, default: 0
    execute 'UPDATE speakers SET events_count = (SELECT COUNT(*) FROM events WHERE speaker_id = speakers.id)'
  end

  def down
    remove_column :speakers, :events_count
  end
end
