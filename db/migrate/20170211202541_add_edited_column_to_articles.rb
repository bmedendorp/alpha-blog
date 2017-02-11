class AddEditedColumnToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :edited, :boolean
  end
end
