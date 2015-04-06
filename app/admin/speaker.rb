ActiveAdmin.register Speaker do
  index do
    selectable_column
    id_column
    column 'Име', :name
    column 'Имейл', :email
    column 'Фирма', :company_or_other, sortable: :company
    column 'Имейл', :phone
    column 'Потв.?', :confirmed?
    column :created_at
    column :last_sign_in_at
    actions
  end
end
