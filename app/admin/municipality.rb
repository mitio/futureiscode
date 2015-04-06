ActiveAdmin.register Municipality do
  menu parent: I18n.t('admin.menu.lists')

  permit_params :name, :state_id

  remove_filter :towns
end
