# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_lang

  private

  def configure_permitted_parameters
    attributes = %i[name email]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def set_lang
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end
end
