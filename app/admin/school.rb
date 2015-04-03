ActiveAdmin.register School do
  remove_filter :town

  index do
    selectable_column
    id_column
    column 'Име', :name
    column 'Град', :town do |row|
      auto_link row.town, row.town.name
    end
    column 'Акт.?', :confirmed_participation
    column 'Контакт', :contact_name
    column :created_at
    column :updated_at
    actions
  end
end
