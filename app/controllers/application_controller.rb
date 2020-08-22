class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = %i[email password name phone_number]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end
end
