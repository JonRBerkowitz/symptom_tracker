class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :type
      t.string :note
      t.integer :user_id
      t.datetime :post_time
    end
  end
end
