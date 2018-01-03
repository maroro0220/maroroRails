class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :username
      t.text :content
      t.string :postimage
      t.timestamps null: false
    end
  end
end
