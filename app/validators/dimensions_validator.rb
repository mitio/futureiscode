class DimensionsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.queued_for_write[:original]

    dimensions = Paperclip::Geometry.from_file(value.queued_for_write[:original].path)

    if options[:min_width] && dimensions.width < options[:min_width]
      record.errors.add attribute, :too_narrow, options.slice(:min_width)
    end

    if options[:min_height] && dimensions.height < options[:min_height]
      record.errors.add attribute, :too_short, options.slice(:min_width)
    end
  end
end
