class Options
  def self.for(type)
    I18n.t("options.#{type}", raise: true).with_indifferent_access
  end
end
