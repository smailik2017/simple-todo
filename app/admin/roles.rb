ActiveAdmin.register Role do
  menu priority: 3, label: proc { I18n.t('active_admin.roles') }

  show title: proc { |role| role.name.truncate(50) } do
    attributes_table do
      row :id
      row :name
      row :description
      row :code
      row :active
      row :updated_at
      row :created_at
    end

    panel I18n.t('active_admin.users') do
      scope = resource.users.order(created_at: :desc)
      table_for scope do
        column :id
        column :name
      end
    end
  end

  index do
    id_column
    column :name
    column :description
    column :active
    column :code
    actions
  end

  filter :id
  filter :name
  filter :description
  filter :active

end