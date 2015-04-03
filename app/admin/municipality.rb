ActiveAdmin.register Municipality do
  menu parent: I18n.t('admin.menu.lists')

  remove_filter :towns
end
