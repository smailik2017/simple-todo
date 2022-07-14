ActiveAdmin.register About do
  menu priority: 100, label: proc { I18n.t('active_admin.about') }

  permit_params :page, :map_location

  show title: proc { |about| 'Название' } do
    attributes_table do
      row :id
      row :page
      row :map_location
      row :updated_at
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :page
      f.file_field :map_location
    end
    f.actions do
      f.action :submit, as: :button
    end
  end


  index do
    id_column
    column :page
    column :map_location
    actions
  end

  filter :name

end