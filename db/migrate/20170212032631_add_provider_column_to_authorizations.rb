class AddProviderColumnToAuthorizations < ActiveRecord::Migration[5.0]
  def change
    add_column :authorizations, :provider, :string
  end
end
