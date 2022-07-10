# frozen_string_literal: true

class AboutController < ApplicationController
  before_action :log_start, :log_params, :log_finish

  def index
    session[:about_counter] ||= 0
    session[:about_counter] += 1
    # I18n.locale = params.fetch(:locale, I18n.default_locale)
    # locale = params.fetch(:locale, I18n.default_locale).to_sym
    # I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    # I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
    @about_page = Rails.cache.fetch("about_page", expires_in: 1.hours) do
      About.with_attached_map_location.first
    end
  end

  private

  def log_start
    Rails.logger.info '###########################################'
  end

  alias log_finish log_start

  def log_params
    Rails.logger.info params.inspect
  end
end
