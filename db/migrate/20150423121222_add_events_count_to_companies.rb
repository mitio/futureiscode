class AddEventsCountToCompanies < ActiveRecord::Migration
  def up
    add_column :companies, :events_count, :integer, null: false, default: 0
    execute 'UPDATE companies SET events_count = COALESCE((SELECT SUM(events_count) FROM speakers WHERE company_id = companies.id), 0)'
  end

  def down
    remove_column :companies, :events_count
  end
end
