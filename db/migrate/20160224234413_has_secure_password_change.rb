class HasSecurePasswordChange < ActiveRecord::Migration
  def change
    remove_column :users, :passsalt
    remove_column :users, :passhash
    add_column :users, :password_digest, :string
  end
end
