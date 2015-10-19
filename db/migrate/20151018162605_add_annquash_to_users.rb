class AddAnnquashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :annquash, :datetime
  end
end
