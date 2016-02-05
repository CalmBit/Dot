class AddTwoPartToU2FRegistrations < ActiveRecord::Migration
  def change
	add_column :u2_f_registrations, :two_part, :boolean
  end
end
