class ChangeAuthorizationsColumnNameToExipresAt < ActiveRecord::Migration[5.0]
  def change
    rename_column :authorizations, :expires_in, :expires_at
  end
end
