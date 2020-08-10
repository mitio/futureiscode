class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

  private

  def check_captcha
    self.resource ||= resource_class.new sign_up_params

    unless verify_recaptcha
      resource.validate # Look for any other validation errors besides reCAPTCHA
      resource.errors.add :captcha, 'трябва да бъде маркирано'

      @minimum_password_length = resource_class.password_length.min

      respond_with resource
    end
  end
end
