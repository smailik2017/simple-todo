class HelpController < ApplicationController
  def index
    @content = YAML.load_file('config/description.yml')['help']
  end
end
