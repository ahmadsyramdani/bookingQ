class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |t|
      t.integer :specialist_id
      t.string :name
      t.string :phone_number

      t.timestamps
    end
  end
end
