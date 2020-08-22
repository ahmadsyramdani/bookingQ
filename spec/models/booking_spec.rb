require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe "Association" do
    it "should belongs to user" do
      t = Booking.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
    it "should belongs to schedule" do
      t = Booking.reflect_on_association(:schedule)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  describe "Booking" do
    let(:user) { User.create(
      email: Faker::Internet.email,
      password: "password123",
      name: Faker::Name.name,
      phone_number: Faker::PhoneNumber.cell_phone_in_e164
    )}
    let(:hospital) { Hospital.create(
      name: 'RS Hermina Pasteur',
      category: 'Rumah Sakit Umum',
      address: 'Jl. Dr. Djunjunan No.107, Pasteur, Kec. Cicendo, Kota Bandung, Jawa Barat'
    )}
    let(:specialist) { Specialist.create(
      name: 'anak'
    )}
    let(:doctor) { Doctor.create(
      specialist: specialist,
      name: Faker::Name.name,
      phone_number: Faker::PhoneNumber.phone_number_with_country_code
    )}
    let(:schedule) { Schedule.create(
      hospital: hospital,
      doctor: doctor,
      day: Time.current.strftime("%A").downcase,
      slot_start: Time.current.hour - 1,
      slot_end: Time.current.hour + 2
    )}
    let(:attend_at) {
      (Time.current.beginning_of_day + schedule.slot_start.hour).strftime('%H:%M')
    }
    let(:booking) {
      Booking.create(
        user: user,
        schedule: schedule,
        appointment_at: Time.current.next_week.advance(:days=>(Time.current.wday-1))
      )
    }
    let(:booking_today) {
      Booking.create(
        user: user,
        schedule: schedule,
        appointment_at: Time.current
      )
    }
    let(:second_booking) {
      Booking.create(
        user: user,
        schedule: schedule,
        appointment_at: Time.current.next_week.advance(:days=>(Time.current.wday-1))
      )
    }
    let(:pass_date_booking) {
      Booking.create(
        user: user,
        schedule: schedule,
        appointment_at: Time.current.last_week.advance(:days=>(Time.current.wday-1)) #0 = monday
      )
    }
    it "create a booking without error" do
      expect(booking.errors).to be_empty
    end
    it "create a booking with error double booking" do
      booking
      expect(second_booking.errors.full_messages.uniq.join(', ')).to eq('User already book the schedule')
    end
    it "can't book the schedule using pass appointment date" do
      expect(pass_date_booking.errors.full_messages.uniq.join(', ')).to eq('Appointment at please choose current or future date')
    end
    it "Have line number, should tell patient to come on time" do
      include AttendTime
      expect(booking.estimated_attend_at).to eq(attend_at)
    end
    it "No line number, should tell patient to come early 30 minute before start" do
      booking.line_number = nil
      expect(booking.estimated_attend_at).to eq('come early 30 minute before start')
    end
    it "should not let patient book the schedule less than 30 minutes before start" do
      expect(booking_today.errors.full_messages.uniq.join(', ')).to eq('Appointment at registration is closed, try another schedule')
    end
    it "doctor should have specialization" do
      expect(doctor.specialist_name).to eq('anak')
    end
  end
end
