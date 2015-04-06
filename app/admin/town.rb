ActiveAdmin.register Town do
  menu parent: I18n.t('admin.menu.lists')

  permit_params :name, :municipality_id
end
