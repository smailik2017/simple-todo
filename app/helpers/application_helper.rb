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
end
