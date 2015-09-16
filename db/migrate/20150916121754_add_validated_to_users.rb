class AddValidatedToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :validated, :boolean
  	add_column :users, :validation_code, :string
  end
end
