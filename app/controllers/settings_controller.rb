# frozen_string_literal: true

class SettingsController < ApplicationController
  def index
    redirect_to edit_user_registration_path
  end
end
