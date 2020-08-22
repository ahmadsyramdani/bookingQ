require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it "should belongs to doctor" do
    t = Schedule.reflect_on_association(:doctor)
    expect(t.macro).to eq(:belongs_to)
  end
  it "should belongs to hospital" do
    t = Schedule.reflect_on_association(:hospital)
    expect(t.macro).to eq(:belongs_to)
  end
  it "should has many bookings" do
    t = Schedule.reflect_on_association(:bookings)
    expect(t.macro).to eq(:has_many)
  end
end
