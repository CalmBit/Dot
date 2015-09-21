class CreateTextPosts < ActiveRecord::Migration
  def change
    create_table :text_posts do |t|
      t.belongs_to :user
      t.string :title
      t.text :content
      t.text :description
      t.string :tags
      t.timestamps null: false
    end
  end
end
