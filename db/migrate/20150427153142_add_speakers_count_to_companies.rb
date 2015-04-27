class AddSpeakersCountToCompanies < ActiveRecord::Migration
  def up
    add_column :companies, :speakers_count, :integer, null: false, default: 0
    execute 'UPDATE companies SET speakers_count = (SELECT COUNT(*) FROM speakers WHERE company_id = companies.id)'
  end

  def down
    remove_column :companies, :speakers_count
  end
end
