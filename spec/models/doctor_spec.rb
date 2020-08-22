require 'rails_helper'

RSpec.describe Doctor, type: :model do
  it "should has many schedule" do
    t = Doctor.reflect_on_association(:schedules)
    expect(t.macro).to eq(:has_many)
  end

  it "should belongs to specialist" do
    t = Doctor.reflect_on_association(:specialist)
    expect(t.macro).to eq(:belongs_to)
  end
end
