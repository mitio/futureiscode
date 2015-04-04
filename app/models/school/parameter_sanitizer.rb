class School::ParameterSanitizer < Devise::ParameterSanitizer
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
      :town_id,
      :address,
      :contact_name,
      :phone,
      :confirmed_participation,
      :visit_dates,
      {disciplines: []},
      {available_equipment: []},
      :meetup_options,
      :remarks,
      :email,
      :password,
      :password_confirmation,
    ]
  end
end
