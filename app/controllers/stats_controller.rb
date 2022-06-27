# frozen_string_literal: true

class StatsController < ApplicationController
  def index
    @users = User.all
  end
end
