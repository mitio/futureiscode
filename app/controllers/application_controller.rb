class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def devise_parameter_sanitizer
    if resource_class == School
      School::ParameterSanitizer.new(School, :school, params)
    elsif resource_class == Speaker
      Speaker::ParameterSanitizer.new(Speaker, :speaker, params)
    else
      super
    end
  end
end
