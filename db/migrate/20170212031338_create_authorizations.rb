class CreateAuthorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :authorizations do |t|
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_in
      t.string :auth_user_id
      t.integer :user_id
      t.timestamps
    end
  end
end
