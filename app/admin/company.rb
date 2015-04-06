ActiveAdmin.register Company do
  permit_params :name, :slug, :url, :logo, :pledged_support

  index do
    selectable_column
    id_column
    column :name
    column :slug
    column :url
    column(:logo) do |resource|
      image_tag resource.logo.url(:small), height: 20 if resource.logo?
    end
    column :pledged_support
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :slug
  filter :url
  filter :pledged_support
  filter :created_at

  form do |f|
    f.inputs 'Информация за фирма' do
      f.input :name
      f.input :slug
      f.input :url
      f.input :logo
      f.input :pledged_support
    end
    f.actions
  end

  show do |resource|
    panel 'Информация за фирма' do
      attributes_table_for resource do
        row :id
        row :name
        row :slug
        row :url do
          link_to resource.url if resource.url.present?
        end
        row :logo do
          if resource.logo?
            link_to resource.logo.url(:original), target: '_blank' do
              image_tag resource.logo.url(:medium)
            end
          end
        end
        row :pledged_support
        row :created_at
        row :updated_at
      end
    end
    active_admin_comments
  end
end
