class RemoveArticleEditedColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :edited
  end
end
