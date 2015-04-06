ActiveAdmin.register Speaker do
  permit_params :name, :email, :company_id, :other_company, :phone

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

  form do |f|
    f.inputs 'Speaker Details' do
      f.input :name
      f.input :email
      f.input :company
      f.input :other_company
      f.input :phone
    end
    f.actions
  end
end
