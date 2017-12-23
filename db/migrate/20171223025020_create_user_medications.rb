class CreateUserMedications < ActiveRecord::Migration[5.1]
  def change
    create_table :user_medications do |t|
      t.integer :user_id
      t.integer :medication_id
    end
  end
end
