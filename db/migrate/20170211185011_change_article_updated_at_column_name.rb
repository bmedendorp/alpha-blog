class ChangeArticleUpdatedAtColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :articles, :updated_ad, :updated_at
  end
end
