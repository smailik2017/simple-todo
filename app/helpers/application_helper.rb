module ApplicationHelper
  def current_date
    Date.current.to_s
  end

  def list_tag(values)
    result = "<ul>"
    values.each do |value|
      result << "<li>#{value}</li>"
    end
    sanitize result << "</ul>"
  end

  def language_link_name
    session[:locale] == I18n.default_locale.to_s ? 'en' : 'ru'
  end

  def action_title(klass, action_name)
    action_case = action_name == 'index' ? 'many' : 'accusative'

    [
      t("label.#{action_name}"),
      t("activerecord.models.#{klass.name.tableize.singularize}.#{action_case}")
    ].join(' ')
  end

  WillPaginate::ViewHelpers.pagination_options[:previous_label] = '<span class="fa fa-arrow-left"></span>' 
  WillPaginate::ViewHelpers.pagination_options[:next_label] = '<span class="fa fa-arrow-right"></span>' 
  
end
