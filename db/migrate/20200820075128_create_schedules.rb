class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :hospital_id
      t.integer :doctor_id
      t.integer :day
      t.integer :slot_start
      t.integer :slot_end

      t.timestamps
    end
  end
end
