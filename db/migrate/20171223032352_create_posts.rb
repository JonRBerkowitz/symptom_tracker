class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.string :type
      t.string :note
      t.string :duration
      t.string :intensity
      t.string :dose
      t.string :post_time
    end
  end
end
