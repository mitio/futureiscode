module DeletableAttachment
  extend ActiveSupport::Concern

  module ClassMethods
    def deletable_attachment(attachment_name)
      delete_flag_name = "delete_#{attachment_name}"

      # def delete_cover_image
      define_method(delete_flag_name) do
        flag = instance_variable_get("@#{delete_flag_name}")
        flag.to_s =~ /^[1ty]/
      end

      # def delete_cover_image=(value)
      define_method "#{delete_flag_name}=" do |value|
        instance_variable_set "@#{delete_flag_name}", value
      end

      before_save do
        if public_send(delete_flag_name)
          public_send "#{attachment_name}=", nil
        end
      end
    end
  end
end
