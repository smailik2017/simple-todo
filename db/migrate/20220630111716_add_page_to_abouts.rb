class AddPageToAbouts < ActiveRecord::Migration[7.0]
  def change
    add_column :abouts, :page, :string
  end
end
