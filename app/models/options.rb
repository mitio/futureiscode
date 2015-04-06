class Options
  SCOPE = 'simple_form.options.defaults'.freeze

  def self.for(type)
    I18n.t("#{SCOPE}.#{type}", raise: true)
  end

  def self.translate(key, type:)
    I18n.t("#{SCOPE}.#{type}.#{key}")
  end
end
