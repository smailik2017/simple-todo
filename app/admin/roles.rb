ActiveAdmin.register Role do
  menu priority: 3, label: 'Роли'

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

    panel 'Пользователи' do
      scope = resource.users.order(created_at: :desc)
      table_for scope do
        column 'ID', :id
        column 'Имя', :name
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