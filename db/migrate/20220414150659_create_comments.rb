class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, comment: 'Коммунтарии пользователя к делам' do |t|
      t.text :content, comment: 'Сщжержимое коментария'
      t.references :user, foreign_key: true,
                    comment: 'Внешний ключ для связи с таблицей USERS'
      t.references :task, foreign_key: true,
                    comment: 'Внешний ключ для связи с таблицей TASKS'

      t.timestamps
    end
  end
end
