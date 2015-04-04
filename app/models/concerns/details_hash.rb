module DetailsHash
  extend ActiveSupport::Concern

  included do
    serialize :details
  end

  module ClassMethods
    def details_attribute(name, any_of: nil, one_of: nil, default_value: nil)
      name = name.to_sym

      # Getter with an optional default value
      define_method name do
        return unless details
        details[name] || default_value
      end

      # Setter, with optional input validation
      define_method "#{name}=" do |value|
        self.details ||= {}

        if any_of
          value = Array(value) & any_of
        elsif one_of
          value = one_of.find { |item| item == value }
        end

        details[name] = value
      end
    end
  end
end
