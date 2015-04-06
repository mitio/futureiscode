ActiveAdmin.register Event do
  permit_params :speaker_id, :school_id, :date, :cover_image, :name, :details,
                :approved, :url, :public_email

  index do
    selectable_column
    id_column
    column :speaker
    column :school
    column 'Town' do |row|
      auto_link row.school.town, row.school.town.name
    end
    column 'Потв.?', :approved
    column 'Дата', :date
    column :name
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Информация за събитие' do
      f.input :speaker
      f.input :school
      f.input :date
      f.input :name
      f.input :approved
      f.input :url
      f.input :public_email
      f.input :details, hint: 'Текстът в полето поддържа Markdown.'
      f.input :cover_image
    end
    f.actions
  end

  show do |resource|
    panel 'Информация за събитие' do
      attributes_table_for resource do
        row :id
        row :speaker
        row :school
        row :date
        row :name
        row :approved
        row :url
        row :public_email
        row :details do
          simple_format resource.details if resource.details
        end
        row :cover_image do
          if resource.cover_image?
            link_to resource.cover_image.url(:original), target: '_blank' do
              image_tag resource.cover_image.url(:medium)
            end
          end
        end
        row :cover_image_file_name
        row :cover_image_content_type
        row :cover_image_file_size do
          number_to_human_size resource.cover_image_file_size if resource.cover_image?
        end
        row :cover_image_updated_at
        row :created_at
        row :updated_at
      end
    end
    active_admin_comments
  end

end
