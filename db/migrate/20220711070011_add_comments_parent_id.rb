class AddCommentsParentId < ActiveRecord::Migration[7.0]
  def change
    add_column :comments,
               :parent_id,
               :integer,
               comment: 'Ссылка на родительский комментарий'
    add_index :comments, :parent_id
  end
end
