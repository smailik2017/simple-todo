# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_lang

  def access_denied(exception)
    sign_out
    redirect_to root_path
  end

  private

  def configure_permitted_parameters
    attributes = %i[name email avatar role_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def set_lang
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  def after_sign_in_path_for(user)
    user.admin? ? admin_users_path : root_path
  end
  
end
