class DimensionsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.queued_for_write[:original]

    dimensions = Paperclip::Geometry.from_file(value.queued_for_write[:original].path)
    width      = dimensions.width.round
    height     = dimensions.height.round

    if options[:min_width] && width < options[:min_width]
      record.errors.add attribute, :image_too_narrow, {current_width: width}.merge(options.slice(:min_width))
    end

    if options[:min_height] && height < options[:min_height]
      record.errors.add attribute, :image_too_short, {current_height: height}.merge(options.slice(:min_width))
    end
  end
end
