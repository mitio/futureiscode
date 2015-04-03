class School::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(
      :name,
      :town_id,
      :address,
      :contact_name,
      :phone,
      :email,
      :password,
      :password_confirmation
    )
  end
end
