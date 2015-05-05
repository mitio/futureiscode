ActiveAdmin.register Speaker do
  permit_params :name, :email, :company_id, :other_company, :phone,
                :password, :password_confirmation

  index do
    selectable_column
    id_column
    column 'Име', :name
    column 'Имейл', :email
    column 'Фирма', :company_or_other, sortable: :company
    column 'Телефон', :phone
    column 'Потв.?', :confirmed?
    column 'Събития', sortable: :events_count do |row|
      if row.events_count > 0
        link_to "#{row.events_count} (виж)", admin_events_path(q: {speaker_id_eq: row.id})
      end
    end
    column :created_at
    column :last_sign_in_at
    actions
  end

  form do |f|
    f.inputs 'Детайли за лектор' do
      f.input :name
      f.input :email, hint: 'На този имейл ще бъде изпратено писмо за потвърждение на профила.'
      f.input :company
      f.input :other_company
      f.input :phone
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end
end
