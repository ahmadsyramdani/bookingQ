class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :schedule_id
      t.date :appointment_at
      t.integer :line_number

      t.timestamps
    end
  end
end
