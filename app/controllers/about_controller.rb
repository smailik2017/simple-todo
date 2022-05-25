class AboutController < ApplicationController
  before_action :log_start, :log_params, :log_finish

  def index
    @content = YAML.load_file('config/description.yml')['about']
  end

  private

  def log_start
    Rails.logger.info "###########################################"
  end

  alias log_finish log_start

  def log_params
    Rails.logger.info params.inspect
  end

end
