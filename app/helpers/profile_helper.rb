module ProfileHelper
  def translated_profile_type_for(resource)
    resource_name =
      if resource.is_a? ActiveRecord::Base
        resource.class.name.underscore
      else
        resource
      end

    t "profile_types.#{resource_name}"
  end
end
