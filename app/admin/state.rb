ActiveAdmin.register State do
  menu parent: I18n.t('admin.menu.lists')

  permit_params :name

  remove_filter :towns
end
