FactoryBot.define do
  categories = %w[Rumah\ Sakit\ Umum Rumah\ Sakit\ Anak Klinik\ Umum]

  factory :hospital, class: Hospital do
    name { "#{Faker::Name.name} Hospital" }
    category { categories.sample }
    address { Faker::Address.full_address }
  end

  factory :specialist, class: Specialist do
    name { 'anak' }
  end

  factory :doctor, class: Doctor do
    specialist { FactoryBot.create(:specialist) }
    name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
  end

  factory :schedule, class: Schedule do
    hospital { FactoryBot.create(:hospital) }
    doctor { FactoryBot.create(:doctor) }
    day { Time.current.strftime("%A").downcase }
    slot_start { Time.current.hour - 1 }
    slot_end { Time.current.hour + 2 }
  end

  factory :user, class: User do
    email { Faker::Internet.email }
    password { 'password123' }
    name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
  end

  factory :booking, class: Booking do
    user { FactoryBot.create(:user) }
    schedule { FactoryBot.create(:schedule) }
    appointment_at { Time.current.next_week.advance(:days=>(Time.current.wday-1)) }
  end
end
