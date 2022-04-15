class AddCommentableComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :commentable, polymorphic: true, null: true
    remove_reference  :comments, :task
  end
end
