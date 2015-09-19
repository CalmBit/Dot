class AddUserlevelToUser < ActiveRecord::Migration
  def change
  	add_column :users,:userlevel, :integer
  end
end