class CreateMedications < ActiveRecord::Migration[5.1]
  def change
    create_table :medications do |t|
      t.string :name
    end
  end
end
