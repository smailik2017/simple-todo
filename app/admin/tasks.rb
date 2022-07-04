ActiveAdmin.register Task do
  menu priority: 2, label: 'Задачи'

  show title: proc { |task| task.name.truncate(50) } do
    attributes_table do
      row :id
      row :name
      row :description
      row :done
      row :user
      row :deadline
      row :updated_at
      row :created_at
    end

    panel 'Подпункты' do
      scope = resource.items.order(created_at: :desc)
      table_for scope do
        column 'ID', :id
        column 'Название', :name
      end
    end
  end

  index do
    id_column
    column 'Содержимое' do |task|
      tag.strong(task.name.truncate(50)) +
      tag.br +
      task.description.truncate(150)
    end
    column :done
    column :user
    actions
  end

  filter :id
  filter :name
  filter :description
  filter :done
  filter :finished_at
  filter :user

end