class Speaker::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(*profile_attributes)
  end

  def account_update
    attributes = profile_attributes + [
      :current_password,
    ]

    default_params.permit(*attributes)
  end

  private

  def profile_attributes
    [
      :name,
      :company_id,
      :other_company,
      :phone,
      :email,
      :password,
      :password_confirmation,
    ]
  end
end
