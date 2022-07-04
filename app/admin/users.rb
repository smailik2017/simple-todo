ActiveAdmin.register User do
  config.sort_order = 'name'
  actions :all, except: [:update, :destroy]

  menu priority: 1, label: 'Пользователи'
  permit_params :email, :name, :active, :role_id, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column  :email
    column  :current_sign_in_at
    column  :sign_in_count
    column  :created_at
    actions
  end

  filter  :email
  filter  :name
  filter  :active
  filter  :role

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :active
      f.input :role
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions do
      f.action :submit, label: 'Отправить', as: :button
    end
  end
end
