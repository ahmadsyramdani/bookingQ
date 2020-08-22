require 'faker'

if Rails.env.development? || Rails.env.test?
  specialists = %w[anak penyakit\ dalam mata bedah\ umum THT gigi dokter\ umum]
  Specialist.destroy_all
  ActiveRecord::Base.connection.execute('TRUNCATE specialists RESTART IDENTITY')

  puts 'Generating ...'
  specialists.each do |name|
    Specialist.create(name: name)
  end
  puts 'Specialist - Done'

  hospitals = [
    {
      name: 'RS Hermina Pasteur',
      category: 'Rumah Sakit Umum',
      address: 'Jl. Dr. Djunjunan No.107, Pasteur, Kec. Cicendo, Kota Bandung, Jawa Barat'
    },
    {
      name: 'Klinik Tivaza',
      category: 'Klinik',
      address: '16, Jl. Dr. Rajiman, Pasir Kaliki, Kec. Cicendo, Kota Bandung, Jawa Barat'
    },
    {
      name: 'RS Hermina Arcamanik',
      category: 'Rumah Sakit Umum',
      address: 'No. 50, Jalan Ahmad Nasution, Antapani Wetan, Kec. Antapani, Kota Bandung, Jawa Barat'
    },
    {
      name: 'RS Pindad Bandung',
      category: 'Rumah Sakit Umum',
      address: 'Sukapura, Kec. Kiaracondong, Kota Bandung, Jawa Barat'
    },
    {
      name: 'RS Advent Bandung',
      category: 'Rumah Sakit Umum',
      address: 'No.161, Jl. Cihampelas, Cipaganti, Kecamatan Coblong, Kota Bandung, Jawa Barat'
    }
  ]

  Hospital.destroy_all
  ActiveRecord::Base.connection.execute('TRUNCATE hospitals RESTART IDENTITY')

  hospitals.each do |item|
    Hospital.create(
      name: item[:name],
      category: item[:category],
      address: item[:address]
    )
  end
  puts 'Hospital - Done'

  Doctor.destroy_all
  Schedule.destroy_all
  ActiveRecord::Base.connection.execute('TRUNCATE doctors RESTART IDENTITY')
  ActiveRecord::Base.connection.execute('TRUNCATE schedules RESTART IDENTITY')

  puts 'generating datas...'
  days = %w[monday tuesday wednesday thursday friday saturday sunday]
  Hospital.all.each do |h|
    doctor_ids = []
    puts 'creating specialist'
    Specialist.all.each do |s|
      6.times do
        doctor = s.doctors.create(
          name: Faker::Name.name,
          phone_number: Faker::PhoneNumber.cell_phone_in_e164
        )
        doctor_ids << doctor.id
      end
    end
    puts 'creating schedule'
    days.each do |day|
      start_hour = 8
      end_hour = 17

      doctor_ids.shuffle.each do |doctor_id|
        puts start_hour
        work_hour = rand(2..3)
        slot_end = (end_hour - start_hour) <= 3 ? 17 : (start_hour + work_hour)
        next if start_hour >= end_hour

        Schedule.create(
          hospital_id: h.id,
          doctor_id: doctor_id,
          day: day,
          slot_start: start_hour,
          slot_end: slot_end
        )
        puts slot_end
        start_hour = (slot_end + 1)
        start_hour = 8 if start_hour >= end_hour
      end
    end
  end
end
