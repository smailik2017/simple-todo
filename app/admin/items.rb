ActiveAdmin.register Item do
  menu priority: 4, label: 'Подпункты'

  show title: proc { |item| item.name.truncate(50) } do
    attributes_table do
      row :id
      row :name
      row :deadline
      row :state
      row :updated_at
      row :created_at
    end
  end

  index do
    id_column
    column :name
    column :deadline
    column :state
    actions
  end

  filter :id
  filter :name
  filter :deadline
  filter :state

end