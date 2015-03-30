class SlugValidator < ActiveModel::EachValidator
  SLUG_FORMAT = /\A[a-z0-9]+[\-a-z0-9]*\z/.freeze

  def validate_each(record, attribute, value)
    return if (value.nil? && options[:allow_nil]) || (value.blank? && options[:allow_blank])

    if value.to_s !~ SLUG_FORMAT
      record.errors.add attribute, :invalid
    end
  end
end
