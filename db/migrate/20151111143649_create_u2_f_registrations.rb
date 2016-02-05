class CreateU2FRegistrations < ActiveRecord::Migration
  def change
    create_table :u2_f_registrations do |t|

	t.string :key_handle
	t.string :public_key
	t.text :certificate
	t.integer :counter
	t.integer :user_id

      t.timestamps null: false
    end
  end
end
