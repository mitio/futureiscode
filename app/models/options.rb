class Options
  def self.for(type)
    I18n.t("simple_form.options.defaults.#{type}", raise: true)
  end
end
