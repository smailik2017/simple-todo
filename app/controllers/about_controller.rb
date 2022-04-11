class AboutController < ApplicationController
  def index
    @content = YAML.load_file('config/description.yml')['about']
  end
end
