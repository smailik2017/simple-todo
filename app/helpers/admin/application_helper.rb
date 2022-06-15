module Admin::ApplicationHelper
  def action_title(klass, action_name)
    action_case = action_name == 'index' ? 'many' : 'accusative'

    [
      t("label.#{action_name}"),
      t("activerecord.models.#{klass.name.tableize.singularize}.#{action_case}")
    ].join(' ')
  end

  def activate_title(user)
    sanitize user.active? ? '<span class="fa fa-check-circle"></span>' : '<span class="fa fa-circle"></span>'
  end
end